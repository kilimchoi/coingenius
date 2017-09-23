module Coinbase
  class Sell < Coinbase::Transaction
    self.table_name = "coinbase_sells"
  end
end
