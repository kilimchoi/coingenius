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
    responses = Hash.new(Hash.new())

    response = HTTParty.get('http://www.coincap.io/front')

    coins = JSON.parse(response.body).sort_by{ |hash| hash['mktcap'].to_f }.reverse

    self.transactions.each do |transaction|
      coin = transaction.coin
      coin_data = coins.select{|api_coin| api_coin['short'] == coin.symbol}.first.with_indifferent_access
      
      daily_data = if responses[coin.symbol]["daily"]
        responses[coin.symbol]["daily"]
      else
        response = HTTParty.get("http://www.coincap.io/history/1day/#{coin.symbol.upcase}")
        responses[coin.symbol]["daily"] = JSON.parse(response.body).with_indifferent_access
      end

      weekly_data = if responses[coin.symbol]["weekly"]
        responses[coin.symbol]["weekly"]
      else
        response = HTTParty.get("http://www.coincap.io/history/7day/#{coin.symbol.upcase}")
        responses[coin.symbol]["weekly"] = JSON.parse(response.body).with_indifferent_access
      end

      monthly_data = if responses[coin.symbol]["monthly"]
        responses[coin.symbol]["monthly"]
      else
        response = HTTParty.get("http://www.coincap.io/history/30day/#{coin.symbol.upcase}")
        responses[coin.symbol]["monthly"] = JSON.parse(response.body).with_indifferent_access
      end
      
      yearly_data = if responses[coin.symbol]["yearly"]
        responses[coin.symbol]["yearly"]
      else
        response = HTTParty.get("http://www.coincap.io/history/365day/#{coin.symbol.upcase}")
        responses[coin.symbol]["yearly"] = JSON.parse(response.body).with_indifferent_access
      end
      #coin.update_attributes(website: data[:homeUrl]) unless coin.website.present?

      if transaction.bought?
        amount_change = transaction.amount
        total_change = (transaction.amount * coin_data[:price].to_f)
      else 
        amount_change = -transaction.amount
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
          daily_price_history: daily_data[:price].map{|history| history},
          weekly_price_history: weekly_data[:price].map{|history| history},
          monthly_price_history: monthly_data[:price].map{|history| history},
          yearly_price_history: yearly_data[:price].map{|history| history},
        }
      end
      responses = Hash.new(Hash.new())
    end

    holdings.each do |key, holding|
      holding[:percent] = holding[:total]/total
    end
    [holdings.values, total]
  end
end
