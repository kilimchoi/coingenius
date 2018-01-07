class CreateBinanceOrder < ActiveRecord::Migration[5.1]
  def change
    create_table :binance_orders do |t|
      t.belongs_to :transaction, foreign_key: true
      t.string :uuid, index: true, unique: true
      t.jsonb :raw_data
      t.datetime :executed_at

      t.timestamps
    end
  end
end
