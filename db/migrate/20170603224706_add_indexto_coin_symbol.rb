class AddIndextoCoinSymbol < ActiveRecord::Migration
  def change
    add_index :coins, :symbol, unique: true
  end
end
