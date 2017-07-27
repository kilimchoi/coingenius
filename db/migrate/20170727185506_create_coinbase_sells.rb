class CreateCoinbaseSells < ActiveRecord::Migration
  def change
    create_table :coinbase_sells do |t|
      t.belongs_to :transaction, index: true, foreign_key: true

      t.jsonb :raw_data, {}
      t.string :uuid, null: false
    end
  end
end