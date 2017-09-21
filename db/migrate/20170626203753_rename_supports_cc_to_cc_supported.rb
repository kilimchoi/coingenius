class RenameSupportsCcToCcSupported < ActiveRecord::Migration[5.1]
  def change
    rename_column :exchanges, :supports_cc, :cc_supported
  end
end
