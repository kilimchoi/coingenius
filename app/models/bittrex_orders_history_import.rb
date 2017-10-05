class BittrexOrdersHistoryImport < ApplicationRecord
  belongs_to :user, optional: true
  has_many :bittrex_orders
end
