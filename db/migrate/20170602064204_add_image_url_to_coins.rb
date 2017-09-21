class AddImageUrlToCoins < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :image_url, :string
  end
end
