class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer :transaction_type
      t.decimal :price
      t.decimal :amount
      t.integer :coin_id
      t.integer :user_id
      t.timestamps null: false
    end

    add_index :transactions, :transaction_type
    add_index :transactions, :coin_id
    add_index :transactions, :user_id
  end
end
