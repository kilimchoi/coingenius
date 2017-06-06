class Coin < ActiveRecord::Base
  has_and_belongs_to_many :exchanges
  has_many :transactions

  attr_accessor :price, :percent_change, :market_cap

  def label
    "#{name} (#{symbol})"
  end
end
