class CreateCoinbaseSents < ActiveRecord::Migration[4.2]
  def change
    create_table :coinbase_sents do |t|
      t.belongs_to :transaction, index: true, foreign_key: true

      t.jsonb :raw_data, {}
      t.string :uuid, null: false
    end
  end
end
