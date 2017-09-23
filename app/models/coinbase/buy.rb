module Coinbase
  class Buy < Coinbase::Transaction
    self.table_name = "coinbase_buys"
  end
end
