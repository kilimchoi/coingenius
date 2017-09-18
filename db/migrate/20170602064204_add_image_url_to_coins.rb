class AddImageUrlToCoins < ActiveRecord::Migration[4.2]
  def change
    add_column :coins, :image_url, :string
  end
end
