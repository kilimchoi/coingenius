module Coinbase
  class Transaction < ApplicationRecord
    self.abstract_class = true
    self.table_name = "transactions"

    belongs_to :user_transaction, class_name: "Transaction", foreign_key: :transaction_id

    validates :uuid, presence: true
  end
end
