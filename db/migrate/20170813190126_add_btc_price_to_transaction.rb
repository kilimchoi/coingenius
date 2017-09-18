class AddBtcPriceToTransaction < ActiveRecord::Migration[4.2]
  def change
    add_column :transactions, :btc_price, :decimal
  end
end
