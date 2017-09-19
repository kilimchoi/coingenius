class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:coinbase]

  validates :username, presence: true, uniqueness: true

  has_many :bittrex_orders_history_imports
  has_many :coins, through: :transactions
  has_many :identities
  has_many :transactions
  has_one :user_api_credential, dependent: :destroy

  def holdings
    holdings = {}
    total = 0
    #we need to process buy transactions first and sell transactions next to cancel each other out. otherwise, order is random.

    merged = self.transactions.bought.where(is_expired: false).includes(:coin) + self.transactions.sold.where(is_expired: false).includes(:coin) + self.transactions.withdrawal.where(is_expired: false).includes(:coin) + self.transactions.deposit.where(is_expired: false).includes(:coin) + self.transactions.received.where(is_expired: false).includes(:coin) + self.transactions.sent.where(is_expired: false).includes(:coin)
    merged.each do |transaction|
      coin = transaction.coin
      holding = holdings[coin.symbol]
      if holding
        yearly_data = holding[:yearly_price_history]
        monthly_data = holding[:monthly_price_history]
        weekly_data = holding[:weekly_price_history]
      else
        yearly_data = Coins::GetCachedPriceHistory.call(coin: coin, days: 365, price_currency: "USD").results
        monthly_data = yearly_data.last(30)
        weekly_data = yearly_data.last(7)
      end
      if transaction.bought? || transaction.withdrawal? || transaction.received?
        amount_change = transaction.amount
        total_change = (transaction.amount * weekly_data.last.to_f)
      else
        if holding && transaction.amount <= holding[:amount]
          amount_change = -transaction.amount
          total_change = -(transaction.amount * weekly_data.last.to_f)
        else
          amount_change = 0
          total_change = 0
        end
      end
      total += total_change
      if holding
        holding[:amount] += amount_change
        holding[:total] += total_change
      else
        holdings[coin.symbol] = {
          coin: coin,
          percent_change: calculate_percentage_diff(weekly_data[-2].to_f, weekly_data[-1].to_f),
          amount: amount_change,
          total: total_change,
          price: weekly_data.last,
          weekly_price_history: weekly_data,
          monthly_price_history: monthly_data,
          yearly_price_history: yearly_data,
        }
      end
    end

    holdings.each do |_key, holding|
      if total > 0
        holding[:percent] = holding[:total]/total
      end
    end
    [holdings.values, total]
  end

  def calculate_percentage_diff(y1, y2)
    ((y2 - y1) / y1) * 100
  end
end
