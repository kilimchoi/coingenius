module Coins
  class SyncDailyPricesForCoinWorker
    include Sidekiq::Worker
    sidekiq_options retry: 5

    # @param [Integer] coin_id
    # @param [Integer] days
    # @param [String]  price_currency
    def perform(coin_id, days, price_currency)
      coin = Coin.find(coin_id)

      prices = Coins::GetDailyPrices.call(
        coin: coin, days: days, include_today: true, price_currency: price_currency
      ).prices

      $redis.pipelined do
        prices.each do |price|
          key = coin.price_history_cache_key(price[:time], price_currency)
          value = price[:close]

          logger.debug "Redis SET #{key} = #{value}"
          $redis.set(key, value)
        end
      end
    end
  end
end
