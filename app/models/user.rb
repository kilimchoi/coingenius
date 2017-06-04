class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true

  has_many :transactions

  def holdings
    holdings = {}
    total = 0
    responses = {}

    response = HTTParty.get('http://www.coincap.io/front')

    coins = JSON.parse(response.body).sort_by{ |hash| hash['mktcap'].to_f }.reverse

    self.transactions.each do |transaction|
      coin = transaction.coin
      coin_data = coins.select{|api_coin| api_coin['short'] == coin.symbol}.first.with_indifferent_access
      puts coin_data

      data = if responses[coin.symbol]
        responses[coin.symbol]
      else
        response = HTTParty.get("https://min-api.cryptocompare.com/data/histoday?fsym=#{coin.symbol}&tsym=USD&limit=7&aggregate=1&e=CCCAGG")
        responses[coin.symbol] = JSON.parse(response.body).with_indifferent_access
      end

      #coin.update_attributes(website: data[:homeUrl]) unless coin.website.present?

      if transaction.bought?
        amount_change = transaction.amount
        total_change = (transaction.amount * coin_data[:price].to_f)
      else 
        amount_change = -transaction
        total_change = -(transaction.amount * coin_data[:price].to_f)
      end

      total += total_change

      if holding = holdings[coin.symbol]
        holding[:amount] += amount_change
        holding[:total] += total_change
      else
        holdings[coin.symbol] = {
          coin: coin,
          percent_change: coin_data[:perc],
          amount: amount_change,
          total: total_change,
          price: coin_data[:price].to_f.round(2),
          price_history: data[:Data].map{|history| history[:close]}
        }
      end 
    end

    holdings.each do |key, holding|
      puts holding
      holding[:percent] = holding[:total]/total
    end
    [holdings.values, total]
  end
end
