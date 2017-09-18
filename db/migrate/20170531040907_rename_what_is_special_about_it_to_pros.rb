class RenameWhatIsSpecialAboutItToPros < ActiveRecord::Migration[4.2]
  def change
    rename_column :coins, :what_is_special_about_it, :pros
  end
end
