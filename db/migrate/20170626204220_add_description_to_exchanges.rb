class AddDescriptionToExchanges < ActiveRecord::Migration[5.1]
  def change
    add_column :exchanges, :description, :text
  end
end
