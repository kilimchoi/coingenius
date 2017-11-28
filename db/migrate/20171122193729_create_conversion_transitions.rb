class CreateConversionTransitions < ActiveRecord::Migration[5.1]
  def change
    create_table :conversion_transitions do |t|
      t.string :to_state, null: false
      t.jsonb :metadata, default: {}
      t.integer :sort_key, null: false
      t.integer :conversion_id, null: false
      t.boolean :most_recent, null: false
      t.timestamps null: false
    end

    # Foreign keys are optional, but highly recommended
    add_foreign_key :conversion_transitions, :conversions

    add_index(:conversion_transitions,
              [:conversion_id, :sort_key],
              unique: true,
              name: "index_conversion_transitions_parent_sort")
    add_index(:conversion_transitions,
              [:conversion_id, :most_recent],
              unique: true,
              where: 'most_recent',
              name: "index_conversion_transitions_parent_most_recent")
  end
end
