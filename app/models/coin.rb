class Coin < ActiveRecord::Base
  has_and_belongs_to_many :exchanges
  has_many :transactions

  attr_accessor :price, :percent_change, :market_cap

  # @param [Integer] timestamp Unix timestamp
  # @param [String] price_currency Price currency
  def price_history_cache_key(timestamp, price_currency)
    "coins:#{id}:prices:#{timestamp}:#{price_currency.downcase}"
  end

  def name_and_symbol
    "#{name} (#{symbol})"
  end
end
