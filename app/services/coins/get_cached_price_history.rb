module Coins
  # This service utilizes Redis in order to get cached prices for Coin.
  # It will return zero prices if there is no cached data.
  #
  # In order to get actual and historical prices for Coin please run SyncDailyPricesForCoinWorker
  class GetCachedPriceHistory
    include Interactor
    include DatesHelper

    delegate :coin, :days, :price_currency, to: :context

    before do
      context.results = {}
    end

    def call
      context.results = timestamps.zip(cached_prices).to_h
    end

    private

    def cached_prices
      $redis.mget(cache_keys)
    end

    def cache_keys
      timestamps.map do |timestamp|
        coin.price_history_cache_key(timestamp, price_currency)
      end
    end

    def timestamps
      dates_before(days_back: days).map { |date| date.strftime("%s").to_i }
    end
  end
end
