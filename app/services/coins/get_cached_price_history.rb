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
      context.results = []
    end

    def call
      sorted_prices.each do |timestamp, cached_price|
        if cached_price.blank?
          Rails.logger.warn "Missing #{coin.symbol} price for #{timestamp}. Using the latest value"
          context.results << context.results.last
        else
          context.results << cached_price
        end
      end
    end

    private

    def sorted_prices
      timestamps.zip(cached_prices).to_h
    end

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
