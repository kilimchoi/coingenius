module Coinbase
  class Sent < Coinbase::Transaction
    self.table_name = "coinbase_sents"
  end
end
