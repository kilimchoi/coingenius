class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :coin, optional: true

  with_options(dependent: :destroy) do
    has_one :coinbase_sell, class_name: "Coinbase::Sell"
    has_one :coinbase_buy, class_name: "Coinbase::Buy"
    has_one :coinbase_deposit, class_name: "Coinbase::Deposit"
    has_one :coinbase_withdrawal, class_name: "Coinbase::Withdrawal"
    has_one :coinbase_sent, class_name: "Coinbase::Sent"
    has_one :coinbase_received, class_name: "Coinbase::Received"
    has_one :bittrex_order
  end

  enum transaction_type: %i(bought sold withdrawal deposit received sent)

  validates :transaction_type, presence: true
  validates :amount, presence: true
  validates :coin_id, presence: true

  def description
    [transaction_type.titleize, coin.name].join(" ")
  end
end
