class RenameBtcPriceToCoinPrice < ActiveRecord::Migration[5.1]
  def change
    add_column    :transactions, :converted_coin_id, :bigint
    rename_column :transactions, :btc_price, :converted_coin_price

    add_index :transactions, :converted_coin_id
    add_foreign_key :transactions, :coins, column: :converted_coin_id

    reversible do |dir|
      dir.up do
        coin_id = Coin.find_by(symbol: "BTC").id

        coin_id && Transaction.where.not(converted_coin_price: nil).update_all(converted_coin_id: coin_id)
      end
    end
  end
end
