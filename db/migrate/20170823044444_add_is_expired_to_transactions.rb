class AddIsExpiredToTransactions < ActiveRecord::Migration[4.2]
  def change
    add_column :transactions, :is_expired, :boolean, default: false
  end
end
