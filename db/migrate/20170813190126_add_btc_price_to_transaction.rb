class AddBtcPriceToTransaction < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :btc_price, :decimal
  end
end
