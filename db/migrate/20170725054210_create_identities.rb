class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :uid
      t.string :provider
      t.belongs_to :user, index: true, foreign_key: true
      t.string :access_token
      t.string :refresh_token
    end

    add_index :identities, %i(uid provider)
  end
end
