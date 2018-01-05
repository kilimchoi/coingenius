class AddBinanceApiKeyAndBinanceApiSecretToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :binance_api_key, :string
    add_column :users, :binance_api_secret, :string
  end
end
