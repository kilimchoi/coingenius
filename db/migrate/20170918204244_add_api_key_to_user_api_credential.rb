class AddApiKeyToUserApiCredential < ActiveRecord::Migration[5.1]
  def change
    add_column :user_api_credentials, :api_key, :string, index: true

    reversible do |dir|
      dir.up do
        UserApiCredential.find_each do |record|
          decrypted_key = record.key

          record.update_column(:api_key, decrypted_key)
        end
      end
    end
  end
end
