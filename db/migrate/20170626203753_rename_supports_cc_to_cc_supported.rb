class RenameSupportsCcToCcSupported < ActiveRecord::Migration
  def change
    rename_column :exchanges, :supports_cc, :cc_supported
  end
end
