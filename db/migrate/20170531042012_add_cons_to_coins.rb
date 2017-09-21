class AddConsToCoins < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :cons, :text
  end
end
