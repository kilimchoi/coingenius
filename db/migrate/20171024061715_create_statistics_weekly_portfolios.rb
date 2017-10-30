class CreateStatisticsWeeklyPortfolios < ActiveRecord::Migration[5.1]
  def change
    create_table :statistics_weekly_portfolios do |t|
      t.belongs_to :user, null: false, foreign_key: { to_table: :users }
      t.string :week_number, null: false
      t.decimal :total, null: false
      t.timestamps
    end
  end
end
