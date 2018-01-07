module Binance
  class Withdrawal < ApplicationRecord
    self.table_name = "binance_withdrawals"

    belongs_to :user_transaction, class_name: "Transaction", foreign_key: :transaction_id, dependent: :destroy
  end
end
