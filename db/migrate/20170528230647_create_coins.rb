class CreateCoins < ActiveRecord::Migration[4.2]
  def change
    create_table :coins do |t|

      t.timestamps null: false
      t.string :symbol
      t.string :description 
      t.string :website 
      t.text :what_is_special_about_it 
      t.string :where_to_buy
      t.string :consensus_mechanism 
      t.string :category
    end
  end
end
