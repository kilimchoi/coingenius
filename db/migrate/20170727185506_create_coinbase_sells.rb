class CreateCoinbaseSells < ActiveRecord::Migration
  def change
    create_table :coinbase_sells do |t|
      t.string :uuid, null: false
      t.text :raw_data, default: "{}"
    end
  end
end
