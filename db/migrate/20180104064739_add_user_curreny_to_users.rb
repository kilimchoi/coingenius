class AddUserCurrenyToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :user_currency, :string
  end
end
