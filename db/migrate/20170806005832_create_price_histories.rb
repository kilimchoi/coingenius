class CreatePriceHistories < ActiveRecord::Migration
  def change
    create_table :price_histories do |t|

      t.timestamps null: false
      t.datetime :timestamp
      t.integer :coin_id
      t.float :coin_price
    end
  end
end
