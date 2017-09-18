module Coinbase
  class Sent < ActiveRecord::Base
    self.table_name = "coinbase_sents"

    belongs_to :user_transaction, class_name: "Transaction", foreign_key: :transaction_id

    validates :uuid, presence: true
  end
end
