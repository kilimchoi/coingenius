class Coin < ActiveRecord::Base
  has_and_belongs_to_many :exchanges
  has_many :transactions

  attr_accessor :price, :percent_change, :market_cap

  def yearly_price_history
    a = []
    last_365_days = get_365_days
    key = price_history_key
    
    last_365_days.map do |ts| 
      key.concat(ts.to_s)
      val = $redis.get(key)
      if val
        a << val
      else
        response = HTTParty.get("https://min-api.cryptocompare.com/data/pricehistorical?fsym=#{symbol.upcase}&tsyms=USD&ts=#{ts}")
        response = JSON.parse(response.body).with_indifferent_access["#{symbol.upcase}"]["USD"]
        $redis.set(key, response)
        $redis.expire(key, 1.day.to_i)
        a << response
      end
      key = price_history_key
    end
    a
  end

  def monthly_price_history
    a = []
    last_30_days = get_30_days
    key = price_history_key
    
    last_30_days.map do |ts| 
      key.concat(ts.to_s)
      val = $redis.get(key)
      if val
        a << val
      else
        response = HTTParty.get("https://min-api.cryptocompare.com/data/pricehistorical?fsym=#{symbol.upcase}&tsyms=USD&ts=#{ts}")
        response = JSON.parse(response.body).with_indifferent_access["#{symbol.upcase}"]["USD"]
        $redis.set(key, response)
        $redis.expire(key, 1.day.to_i)
        a << response
      end
      key = price_history_key
    end
    a
  end

  def weekly_price_history
    a = []
    last_7_days = get_7_days
    key = price_history_key
    
    last_7_days.map do |ts| 
      key.concat(ts.to_s)
      val = $redis.get(key)
      if val
        a << val
      else
        response = HTTParty.get("https://min-api.cryptocompare.com/data/pricehistorical?fsym=#{symbol.upcase}&tsyms=USD&ts=#{ts}")
        response = JSON.parse(response.body).with_indifferent_access["#{symbol.upcase}"]["USD"]
        $redis.set(key, response)
        $redis.expire(key, 1.day.to_i)
        a << response
      end
      key = price_history_key
    end
    a
  end

  def price_history_key
    "#{symbol}_price_history"
  end

  def get_7_days
    a = []
    7.downto(1) do |i|
      a << (Time.now - i.day).strftime("%Y-%m-%d")
    end
    a.map {|t| t.to_time.to_i}
  end

  def get_30_days
    a = []
    30.downto(1) do |i|
      a << (Time.now - i.day).strftime("%Y-%m-%d")
    end
    a.map {|t| t.to_time.to_i}
  end

  def get_365_days
    a = []
    365.downto(1) do |i|
      a << (Time.now - i.day).strftime("%Y-%m-%d")
    end
    a.map {|t| t.to_time.to_i}
  end
end
