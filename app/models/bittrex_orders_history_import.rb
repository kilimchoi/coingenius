class BittrexOrdersHistoryImport < ActiveRecord::Base
  has_many :bittrex_orders
end
