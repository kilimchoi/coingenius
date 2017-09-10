class BittrexOrdersHistoryImport < ActiveRecord::Base
  belongs_to :user
  has_many :bittrex_orders
end
