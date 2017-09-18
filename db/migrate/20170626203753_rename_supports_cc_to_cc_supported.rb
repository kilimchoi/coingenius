class RenameSupportsCcToCcSupported < ActiveRecord::Migration[4.2]
  def change
    rename_column :exchanges, :supports_cc, :cc_supported
  end
end
