module Coinbase
  class Received < Coinbase::Transaction
    self.table_name = "coinbase_receiveds"
  end
end
