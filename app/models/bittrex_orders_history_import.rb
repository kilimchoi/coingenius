class BittrexOrdersHistoryImport < ApplicationRecord
  belongs_to :user
  has_many :bittrex_orders
end
