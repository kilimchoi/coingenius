class AddRankToExchanges < ActiveRecord::Migration[4.2]
  def change
    add_column :exchanges, :rank, :integer
  end
end
