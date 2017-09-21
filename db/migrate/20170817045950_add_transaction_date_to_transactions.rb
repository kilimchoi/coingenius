class AddTransactionDateToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :transaction_date, :datetime
  end
end
