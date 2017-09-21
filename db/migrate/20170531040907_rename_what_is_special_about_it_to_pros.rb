class RenameWhatIsSpecialAboutItToPros < ActiveRecord::Migration[5.1]
  def change
    rename_column :coins, :what_is_special_about_it, :pros
  end
end
