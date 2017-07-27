class CreateCoinbaseSells < ActiveRecord::Migration
  def change
    create_table :coinbase_sells do |t|
      t.string :uuid, null: false
      t.jsonb :raw_data, {}
    end
  end
end
