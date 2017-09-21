class CreateJoinTableCoinsExchanges < ActiveRecord::Migration[5.1]
  def change
    create_join_table :coins, :exchanges do |t|
      t.integer :coin_id
      t.integer :exchange_id
      # t.index [:coin_id, :exchange_id]
      # t.index [:exchange_id, :coin_id]
    end
  end
end
