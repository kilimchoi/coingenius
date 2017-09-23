module Coinbase
  class Withdrawal < Coinbase::Transaction
    self.table_name = "coinbase_withdrawals"
  end
end
