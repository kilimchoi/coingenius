class AddRankToExchanges < ActiveRecord::Migration
  def change
    add_column :exchanges, :rank, :integer
  end
end
