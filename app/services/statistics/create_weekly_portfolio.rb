module Statistics
  class CreateWeeklyPortfolio
    include Interactor

    delegate :formatted_year_and_week, :user, :today_timestamp, to: :context
    delegate :weekly_user_transactions_groups, to: :user

    before do
      context.today_timestamp = Time.zone.now.beginning_of_day.to_i
      context.formatted_year_and_week = FormattedYearAndWeek.new.value
    end

    def call
      context.weekly_portfolio = Statistics::WeeklyPortfolio.create(
        total: total,
        user: user,
        week_number: formatted_year_and_week
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
