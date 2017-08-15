class Coin < ActiveRecord::Base
  has_and_belongs_to_many :exchanges
  has_many :transactions

  attr_accessor :price, :percent_change, :market_cap

  def price_history(days=7)
    a = []
    day_array = Coin.days_ago(days)
    day_array.each do |timestamp|
      puts "id is #{id}, timestap is #{timestamp}"
      priceHistory = PriceHistory.find_by_timestamp_and_coin_id(timestamp, id) 
      a << priceHistory.coin_price
    end
    a[-1] = $redis.get("#{symbol}_price_today")
    a
  end

  def price_history_key(timestamp)
    "#{symbol}_price_history_#{timestamp}"
  end

  def self.days_ago(days=7)
     a = []
     (days-1).downto(0) do |i|
       a << (Date.today - i.days).to_time(:utc)
     end
     a
  end

  def name_and_symbol
    "#{name} (#{symbol})" 
  end
end
