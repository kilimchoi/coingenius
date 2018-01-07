class CreateBinanceDeposits < ActiveRecord::Migration[5.1]
  def change
    create_table :binance_deposits do |t|
      t.jsonb :raw_data
      t.datetime :executed_at
      t.string :uuid, index: true, unique: true

      t.timestamps
    end
  end
end
