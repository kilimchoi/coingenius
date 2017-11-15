module WeeklyUserTransactionsGroups
  class TotalPrice
    DEFAULT_CURRENCY = "USD".freeze

    attr_reader :transactions_group, :datetime

    delegate :coin, :total_amount, to: :transactions_group

    def initialize(transactions_group:, datetime:)
      @transactions_group = transactions_group
      @datetime = datetime
    end

    def value
      @value ||= total_amount * current_price
    end

    private

    def current_price
      prices[timestamp].to_f
    end

    def prices
      Coins::GetCachedPriceHistory.call(
        coin: coin,
        days: days,
        price_currency: DEFAULT_CURRENCY
      ).results
    end

    def days
      diff = (Time.zone.now.to_date - datetime.to_date).to_i.abs
      diff = 1 if diff.zero?
      diff
    end

    def timestamp
      datetime.beginning_of_day.to_i
    end
  end
end
