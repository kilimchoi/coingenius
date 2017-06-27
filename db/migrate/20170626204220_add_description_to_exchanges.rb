class AddDescriptionToExchanges < ActiveRecord::Migration
  def change
    add_column :exchanges, :description, :text
  end
end
