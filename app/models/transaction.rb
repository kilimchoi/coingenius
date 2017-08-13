class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :coin

  has_one :coinbase_sell, class_name: "Coinbase::Sell"
  has_one :coinbase_buy, class_name: "Coinbase::Buy"
  has_one :bittrex_order

  enum transaction_type: %i(bought sold)

  validates :transaction_type, presence: true
  validates :amount, presence: true
  validates :coin_id, presence: true

  def description
    [transaction_type.titleize, coin.name].join(" ")
  end
end
