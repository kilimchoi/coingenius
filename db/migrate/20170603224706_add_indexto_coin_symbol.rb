class AddIndextoCoinSymbol < ActiveRecord::Migration[4.2]
  def change
    add_index :coins, :symbol, unique: true
  end
end
