module Binance
  class Deposit < ApplicationRecord
    self.table_name = "binance_deposits"

    belongs_to :user_transaction, class_name: "Transaction", foreign_key: :transaction_id, dependent: :destroy
  end
end
