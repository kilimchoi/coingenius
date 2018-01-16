module Statistics
  class UpdateWeeklyPortfolio
    include Interactor

    delegate :transaction, to: :context
    delegate :coin, :is_expired, :user, :transaction_date, to: :transaction

    def call
      return if is_expired
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
      context.transactions_group ||= WeeklyUserTransactionsGroup.find_by(
        coin: coin,
        user: user,
        week_number: formatted_week_number
      )
    end

    def total_price
      Portfolios::TotalMoneyPrice.calculate(
        coin: coin,
        total_amount: transactions_group.total_amount,
        datetime: transaction_date
      )
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
