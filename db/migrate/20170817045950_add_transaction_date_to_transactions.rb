class AddTransactionDateToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :transaction_date, :datetime
  end
end
