class CreateBinanceWithdrawals < ActiveRecord::Migration[5.1]
  def change
    create_table :binance_withdrawals do |t|
      t.string :uuid
      t.datetime :executed_at
      t.jsonb :raw_data
      t.belongs_to :transaction, index: true

      t.timestamps
    end

    add_index :binance_withdrawals, :uuid, unique: true
  end
end
