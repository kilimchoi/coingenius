module Statistics
  class CreateWeeklyPortfolio
    include Interactor

    delegate :datetime, :user, to: :context
    delegate :weekly_user_transactions_groups, to: :user

    before do
      context.datetime ||= Time.zone.now
    end

    def call
      context.weekly_portfolio = Statistics::WeeklyPortfolio.find_or_create_by(
        user: user,
        week_number: FormattedYearAndWeek.new(datetime).value
      )
      context.weekly_portfolio.update(total: total)
    end

    private

    def total
      weekly_user_transactions_groups
        .includes(:coin)
        .recent_by_coin
        .sum do |group|
          Portfolios::TotalMoneyPrice.calculate(
            coin: group.coin,
            total_amount: group.total_amount,
            datetime: datetime
          )
        end
    end
  end
end
