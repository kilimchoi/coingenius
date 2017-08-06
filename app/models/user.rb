class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:coinbase]

  validates :username, presence: true, uniqueness: true

  has_many :identities
  has_many :transactions

  def holdings
    holdings = {}
    total = 0
    responses = Hash.new(Hash.new([]))

    response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/')

    coins = JSON.parse(response.body).sort_by{ |hash| hash['market_cap_usd'].to_f }.reverse
    merged = self.transactions.bought.includes(:coin) + self.transactions.sold.includes(:coin)
    merged.each do |transaction|
      coin = transaction.coin
      coin_data = coins.select{|api_coin| api_coin['symbol'] == coin.symbol}&.first&.with_indifferent_access
      holding = holdings[coin.symbol]
      if holding
        yearly_data = holding[:yearly_price_history]
        monthly_data = holding[:monthly_price_history]
        weekly_data = holding[:weekly_price_history]
      else
        yearly_data = coin.price_history(365)
        monthly_data = yearly_data.last(30)
        weekly_data = yearly_data.last(7)
      end

      if transaction.bought?
        amount_change = transaction.amount.to_i
        total_change = (transaction.amount.to_i * weekly_data.last.to_f)
      elsif transaction.sold?
        if holding && transaction.amount <= holding[:amount]
          amount_change = -transaction.amount.to_i
          total_change = -(transaction.amount.to_i * weekly_data.last.to_f)
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
          percent_change: if coin_data 
                            coin_data[:percent_change_24h] 
                          else 
                            "N/A" 
                          end,
          amount: amount_change,
          total: total_change,
          price: weekly_data.last,
          weekly_price_history: weekly_data,
          monthly_price_history: monthly_data,
          yearly_price_history: yearly_data,
        }
      end
      responses = Hash.new(Hash.new([]))
    end

    holdings.each do |key, holding|
      holding[:percent] = holding[:total]/total
    end
    [holdings.values, total]
  end
end
