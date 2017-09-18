class AddAttributesToExchanges < ActiveRecord::Migration[4.2]
  def change
    add_column :exchanges, :pros, :text
    add_column :exchanges, :cons, :text
    add_column :exchanges, :supports_cc, :boolean
    add_column :exchanges, :verification_required, :boolean
    add_column :exchanges, :deposit_withdrawal_limit, :text
  end
end
