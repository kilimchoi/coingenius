class CreateBittrexOrdersHistoryImport < ActiveRecord::Migration[5.1]
  def change
    create_table :bittrex_orders_history_imports do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.text :file_content
      t.datetime :processed_at

      t.timestamps
    end

    add_belongs_to :bittrex_orders, :bittrex_orders_history_import
    add_foreign_key :bittrex_orders, :bittrex_orders_history_imports
  end
end
