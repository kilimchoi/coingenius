module Statistics
  class UpdateWeeklyPortfolio
    include Interactor

    delegate :transaction, to: :context
    delegate :coin, :user, :transaction_date, to: :transaction

    def call
      return if current_week?

      WeeklyUserTransactionsGroup.refresh
      update_portfolio
    end

    private

    def current_week?
      transaction_date >= Time.zone.now.beginning_of_week
    end

    def formatted_week_number
      FormattedYearAndWeek.new(transaction_date).value
    end

    def transactions_group
      WeeklyUserTransactionsGroup.find_by(
        coin: coin,
        user: user,
        week_number: formatted_week_number
      )
    end

    def total_price
      WeeklyUserTransactionsGroups::TotalPrice.new(
        transactions_group: transactions_group,
        datetime: transaction_date
      ).value
    end

    def update_portfolio
      portfolio = Statistics::WeeklyPortfolio.find_or_create_by(
        user: user,
        week_number: formatted_week_number
      )

      portfolio.update(total: total_price)
    end
  end
end
