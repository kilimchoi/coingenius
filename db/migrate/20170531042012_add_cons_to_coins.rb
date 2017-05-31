class AddConsToCoins < ActiveRecord::Migration
  def change
    add_column :coins, :cons, :text
  end
end
