class RemoveEncryptedKeyFromUserApiCredential < ActiveRecord::Migration[5.1]
  def change
    remove_column :user_api_credentials, :encrypted_key, :string
    remove_column :user_api_credentials, :encrypted_key_iv, :string

    rename_column :user_api_credentials, :api_key, :key

    add_index :user_api_credentials, :key
  end
end
