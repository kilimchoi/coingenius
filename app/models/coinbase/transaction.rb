module Coinbase
  class Transaction < ApplicationRecord
    self.abstract_class = true
    #TODO: we should not have table_name for abstract_class
    self.table_name = "transactions"

    belongs_to :user_transaction, class_name: "Transaction", foreign_key: :transaction_id

    validates :uuid, presence: true
  end
end
