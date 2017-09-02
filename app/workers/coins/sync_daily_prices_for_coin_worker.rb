module Coins
  class SyncDailyPricesForCoinWorker
    include Sidekiq::Worker
    sidekiq_options retry: 5

    # @param [Integer] coin_id
    # @param [Integer] days
    # @param [String]  price_currency
    def perform(coin_id, days, price_currency)
      coin = Coin.find(coin_id)

      prices = Coins::GetDailyPrices.call(currency: coin.symbol, days: days, price_currency: price_currency).prices

      $redis.pipelined do
        prices.each do |price|
          key = "coins:#{coin_id}:prices:#{price[:time]}:#{price_currency.downcase}"

          $redis.setnx(key, price[:close])
        end
      end
    end
  end
end
