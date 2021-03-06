class BittrexOrder < ApplicationRecord
  belongs_to :user_transaction, class_name: "Transaction", foreign_key: :transaction_id, dependent: :destroy
  belongs_to :bittrex_orders_history_import, optional: true

  validates :executed_at, presence: true
end
