class RenameExchangeToWebsite < ActiveRecord::Migration
  def change
    rename_column :exchanges, :exchange, :website
  end
end
