module Statistics
  class CalculatePortfolioTotalChange
    include Interactor

    delegate :user, :portfolio_totals, :time, to: :context

    before do
      context.portfolio_totals ||= user&.portfolio_totals&.includes(:coin)
    end

    def call
      context.difference = current - previous
      context.percentage_difference = PercentageChange.new(
        previous: previous,
        current: current
      ).value
    end

    private

    def current
      portfolio_totals.sum do |portfolio_total|
        Portfolios::TotalMoneyPrice.calculate(
          coin: portfolio_total.coin,
          total_amount: portfolio_total.total_amount
        )
      end
    end

    def previous
      portfolio_totals.sum do |portfolio_total|
        Portfolios::TotalMoneyPrice.calculate(
          coin: portfolio_total.coin,
          datetime: time,
          total_amount: portfolio_total.total_amount
        )
      end
    end
  end
end
