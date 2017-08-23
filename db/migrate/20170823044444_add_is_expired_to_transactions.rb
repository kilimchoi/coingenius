class AddIsExpiredToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :is_expired, :boolean, default: false
  end
end
