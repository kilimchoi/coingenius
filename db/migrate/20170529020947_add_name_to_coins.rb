class AddNameToCoins < ActiveRecord::Migration[4.2]
  def change
    add_column :coins, :name, :string
  end
end
