class RenameWhatIsSpecialAboutItToPros < ActiveRecord::Migration
  def change
    rename_column :coins, :what_is_special_about_it, :pros
  end
end
