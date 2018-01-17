module Portfolios
  class Difference
    def initialize(portfolio_totals:, time:)
      @portfolio_totals = portfolio_totals.includes(:coin)
      @time = time
    end

    def difference
      @_difference ||= (current - previous).round(2)
    end

    def percentage_difference
      @_percentage_difference ||= PercentageChange.calculate(
        previous: previous,
        current: current
      )
    end

    private

    attr_reader :portfolio_totals, :time

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
