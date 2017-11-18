class CreateConversions < ActiveRecord::Migration[5.1]
  def change
    create_table :conversions do |t|
      t.integer :sending_coin_id, index: true
      t.integer :receive_coin_id, index: true
      t.string :return_address, comment: "Address for refunding in case of failed conversion"
      t.string :withdrawal_address, comment: "Address to send requested coin"
      t.string :deposit_address, comment: "Address to send coin to"
      t.jsonb :raw_data, comment: "Raw response from ShapeShift"

      t.timestamps
    end

    add_foreign_key :conversions, :coins, column: "sending_coin_id"
    add_foreign_key :conversions, :coins, column: "receive_coin_id"
  end
end
