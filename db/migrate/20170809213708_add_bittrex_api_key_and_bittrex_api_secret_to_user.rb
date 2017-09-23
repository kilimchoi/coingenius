class AddBittrexApiKeyAndBittrexApiSecretToUser < ActiveRecord::Migration
  def change
    add_column :users, :bittrex_api_key, :string
    add_column :users, :bittrex_api_secret, :string
  end
end
