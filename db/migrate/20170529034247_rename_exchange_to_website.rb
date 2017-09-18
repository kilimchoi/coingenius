class RenameExchangeToWebsite < ActiveRecord::Migration[4.2]
  def change
    rename_column :exchanges, :exchange, :website
  end
end
