module Coinbase
  class Sell < ApplicationRecord
    self.table_name = "coinbase_sells"

    belongs_to :user_transaction, class_name: "Transaction", foreign_key: :transaction_id

    validates :uuid, presence: true
  end
end
