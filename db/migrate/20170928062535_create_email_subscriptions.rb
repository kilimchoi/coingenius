class CreateEmailSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :email_subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :enabled, default: false
      t.string :kind, default: :weekly_portfolio_report

      t.timestamps
    end
  end
end
