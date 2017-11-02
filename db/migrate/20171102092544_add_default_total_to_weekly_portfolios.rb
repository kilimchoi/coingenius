class AddDefaultTotalToWeeklyPortfolios < ActiveRecord::Migration[5.1]
  def change
    change_column_default :statistics_weekly_portfolios, :total, 0
  end
end
