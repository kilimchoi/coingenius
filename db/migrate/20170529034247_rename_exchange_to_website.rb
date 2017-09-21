class RenameExchangeToWebsite < ActiveRecord::Migration[5.1]
  def change
    rename_column :exchanges, :exchange, :website
  end
end
