class AddFeesToExchanges < ActiveRecord::Migration
  def change
    add_column :exchanges, :fees, :text
  end
end
