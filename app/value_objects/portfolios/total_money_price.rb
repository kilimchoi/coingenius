module Portfolios
  class TotalMoneyPrice < ::BaseValueObject
    DEFAULT_CURRENCY = "USD".freeze

    attr_reader :coin, :total_amount, :datetime, :currency

    def initialize(coin:, total_amount:, datetime: Time.zone.now, currency: DEFAULT_CURRENCY)
      @coin = coin
      @total_amount = total_amount
      @datetime = datetime
      @currency = currency
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
        price_currency: currency
      ).results
    end

    def days
      (Time.zone.now.to_date - datetime.to_date).to_i.abs.succ
    end

    def timestamp
      datetime.beginning_of_day.to_i
    end
  end
end
