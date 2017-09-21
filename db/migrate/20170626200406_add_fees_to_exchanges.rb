class AddFeesToExchanges < ActiveRecord::Migration[5.1]
  def change
    add_column :exchanges, :fees, :text
  end
end
