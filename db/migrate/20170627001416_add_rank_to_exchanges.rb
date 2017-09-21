class AddRankToExchanges < ActiveRecord::Migration[5.1]
  def change
    add_column :exchanges, :rank, :integer
  end
end
