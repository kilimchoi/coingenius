class AddDescriptionToExchanges < ActiveRecord::Migration[4.2]
  def change
    add_column :exchanges, :description, :text
  end
end
