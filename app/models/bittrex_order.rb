class BittrexOrder < ActiveRecord::Base
  belongs_to :user_transaction, class_name: "Transaction", foreign_key: :transaction_id
  belongs_to :bittrex_orders_history_import

  validates :executed_at, presence: true
end
