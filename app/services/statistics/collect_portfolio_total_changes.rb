module Statistics
  class CollectPortfolioTotalChanges
    include Interactor
    include Interactor::Contracts

    expects do
      required(:user).filled
    end

    assures do
      required(:user).filled
    end

    on_breach do |breaches|
      context.fail!(breaches)
    end

    delegate :user, :ranges, :portfolio_totals, to: :context

    before do
      context.ranges = [
        1.week.ago,
        1.month.ago,
        1.year.ago
      ]
      context.portfolio_totals = user.portfolio_totals.includes(:coin)
    end

    def call
      context.results = ranges.map do |time|
        Portfolios::Difference.new(portfolio_totals: portfolio_totals, time: time)
      end
    end
  end
end
