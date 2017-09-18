module Coinbase
  class Received < ActiveRecord::Base
    self.table_name = "coinbase_receiveds"

    belongs_to :user_transaction, class_name: "Transaction", foreign_key: :transaction_id

    validates :uuid, presence: true
  end
end
