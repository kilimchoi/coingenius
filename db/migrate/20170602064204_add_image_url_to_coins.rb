class AddImageUrlToCoins < ActiveRecord::Migration
  def change
    add_column :coins, :image_url, :string
  end
end
