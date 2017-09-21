class AddIsExpiredToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :is_expired, :boolean, default: false
  end
end
