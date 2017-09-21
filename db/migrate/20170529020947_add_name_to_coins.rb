class AddNameToCoins < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :name, :string
  end
end
