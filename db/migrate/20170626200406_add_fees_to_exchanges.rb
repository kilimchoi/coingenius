class AddFeesToExchanges < ActiveRecord::Migration[4.2]
  def change
    add_column :exchanges, :fees, :text
  end
end
