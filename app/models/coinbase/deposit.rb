module Coinbase
  class Deposit < Coinbase::Transaction
    self.table_name = "coinbase_deposits"
  end
end
