class CreateExchanges < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|

      t.timestamps null: false
      t.string :name
      t.string :exchange
    end
  end
end
