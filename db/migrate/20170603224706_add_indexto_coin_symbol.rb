class AddIndextoCoinSymbol < ActiveRecord::Migration[5.1]
  def change
    add_index :coins, :symbol, unique: true
  end
end
