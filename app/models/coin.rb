class Coin < ActiveRecord::Base
  has_and_belongs_to_many :exchanges
  has_many :transactions

  attr_accessor :price, :percent_change, :market_cap

  def price_history(days=7)
    a = []
    day_array = Coin.days_ago(days)
    keys = day_array.map {|timestamp| price_history_cache_key(timestamp, "USD")}

    cached_prices = $redis.mget(keys)

    daily_prices = day_array.zip(cached_prices).to_h
    daily_prices.each do |timestamp, cached_price|
      if cached_price.blank?
        Rails.logger.warn "Missing #{symbol} price for #{timestamp}. Using the latest value"
        a << a.last
      else
        a << cached_price
      end
    end

    a
  end

  # @param [Integer] timestamp Unix timestamp
  # @param [String] price_currency Price currency
  def price_history_cache_key(timestamp, price_currency)
    "coins:#{id}:prices:#{timestamp}:#{price_currency.downcase}"
  end

  def self.days_ago(days = 7)
    a = []
    (days - 1).downto(0) do |i|
      a << (Date.today - i.days).strftime('%s').to_i
    end
    a
  end

  def name_and_symbol
    "#{name} (#{symbol})"
  end
end
