class BittrexOrder < ActiveRecord::Base
  belongs_to :user_transaction, class_name: "Transaction", foreign_key: :transaction_id
end
