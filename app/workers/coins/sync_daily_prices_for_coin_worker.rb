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
        prices.each_with_index do |price, index|
          key = "coins:#{coin_id}:prices:#{price[:time]}:#{price_currency.downcase}"

          logger.debug "Redis SET #{key} = #{price[:close]}"
          $redis.set(key, price[:close])
        end
      end
    end
  end
end
