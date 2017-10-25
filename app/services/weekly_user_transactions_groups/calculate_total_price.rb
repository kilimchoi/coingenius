module WeeklyUserTransactionsGroups
  class CalculateTotalPrice
    include Interactor

    DEFAULT_CURRENCY = "USD".freeze

    delegate :current_price, :transactions_group, to: :context
    delegate :coin, :total_amount, to: :transactions_group

    before do
      today_timestamp = Time.zone.now.beginning_of_day.to_i
      context.current_price = Coins::GetCachedPriceHistory.call(
        coin: coin,
        days: 1,
        price_currency: DEFAULT_CURRENCY
      )[today_timestamp].to_f
    end

    def call
      context.total_price = total_amount * current_price
    end
  end
end
