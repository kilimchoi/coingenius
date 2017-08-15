class Coin < ActiveRecord::Base
  has_and_belongs_to_many :exchanges
  has_many :transactions

  attr_accessor :price, :percent_change, :market_cap

  def price_history(days=7)
    a = []
    day_array = Coin.days_ago(days)
    if $redis.get(price_history_key(day_array.last)) && $redis.get(price_history_key(day_array.first))
      day_array.each do |day_timestamp|
        a << $redis.get(price_history_key(day_timestamp)).to_f
      end
    else
      if self.symbol == "MIOTA"
        response = HTTParty.get("https://min-api.cryptocompare.com/data/histoday?fsym=IOT&tsym=USD&limit=#{days-2}&e=CCCAGG")
      else
        response = HTTParty.get("https://min-api.cryptocompare.com/data/histoday?fsym=#{symbol.upcase}&tsym=USD&limit=#{days-2}&e=CCCAGG")
      end
      prices = JSON.parse(response.body).with_indifferent_access["Data"]
      prices.each do |price|
        timestamp = Time.at(price[:time])
        key = price_history_key(timestamp.beginning_of_day.to_i)
        $redis.set(key, price[:close])
        a << price[:close]
      end
    end

    if $redis.get("#{symbol}_price_today")
      a << $redis.get("#{symbol}_price_today")
    end
    puts "there are #{a.count} datapoints"
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
