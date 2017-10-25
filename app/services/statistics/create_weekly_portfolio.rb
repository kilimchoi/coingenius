module Statistics
  class CreateWeeklyPortfolio
    include Interactor

    delegate :formatted_year_and_week, :user, to: :context
    delegate :weekly_user_transactions_groups, to: :user

    def call
      context.weekly_portfolio = Statistics::WeeklyPortfolio.create(
        total: total,
        user: user,
        week_number: FormattedYearAndWeek.new.value
      )
    end

    private

    def group_total(group)
      WeeklyUserTransactionsGroups::CalculateTotalPrice.call(transactions_group: group).total_price
    end

    def total
      weekly_user_transactions_groups
        .includes(:coin)
        .recent_by_coin
        .sum { |group| group_total(group) }
    end
  end
end
