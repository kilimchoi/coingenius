module Statistics
  class UpdateWeeklyPortfolio
    include Interactor

    delegate :transaction, to: :context
    delegate :coin, :user, :transaction_date, to: :transaction

    def call
      return if current_or_future?

      update_portfolio
    end

    private

    def current_or_future?
      transaction_date >= Time.zone.now
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
      WeeklyUserTransactionsGroups::CalculateTotalPrice.call(
        transactions_group: transactions_group
      ).total_price
    end

    def update_portfolio
      Statistics::WeeklyPortfolio
        .find_by(user: user, week_number: formatted_week_number)
        &.update(total: total_price)
    end
  end
end
