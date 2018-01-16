class CreateStatisticsPortfolioTotals < ActiveRecord::Migration[5.0]
  def change
    create_view :statistics_portfolio_totals
  end
end
