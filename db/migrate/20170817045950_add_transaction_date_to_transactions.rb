class AddTransactionDateToTransactions < ActiveRecord::Migration[4.2]
  def change
    add_column :transactions, :transaction_date, :datetime
  end
end
