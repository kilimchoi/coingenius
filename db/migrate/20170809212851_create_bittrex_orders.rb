class CreateBittrexOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :bittrex_orders do |t|
      t.belongs_to :transaction, index: true, foreign_key: true
      t.jsonb :raw_data
      t.string :uuid

      t.timestamps null: false
    end
  end
end
