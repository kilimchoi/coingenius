class AddShapeshiftConvertibleToCoin < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :shapeshift_convertible, :boolean, default: false, null: false
  end
end
