module Coins
  class SyncDailyPricesForCoinsWorker
    include Sidekiq::Worker
    sidekiq_options retry: 5

    def perform
      Coin.pluck(:id).each do |coin_id|
        Coins::SyncDailyPricesForCoinWorker.perform_async(coin_id, 365, "USD")
      end
    end
  end
end
