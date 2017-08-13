class AddBtcPriceToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :btc_price, :decimal
  end
end
