class AddNameToCoins < ActiveRecord::Migration
  def change
    add_column :coins, :name, :string
  end
end
