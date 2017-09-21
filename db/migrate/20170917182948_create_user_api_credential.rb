class CreateUserApiCredential < ActiveRecord::Migration[5.1]
  def change
    create_table :user_api_credentials do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :encrypted_key
      t.string :encrypted_key_iv
      t.string :encrypted_secret
      t.string :encrypted_secret_iv
      t.integer :nonce, default: 0, null: false

      t.timestamps null: false
    end

    reversible do |dir|
      dir.up { User.find_each.map(&:create_user_api_credential!) }
    end
  end
end
