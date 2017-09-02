module Coins
  class SyncDailyPricesForCoinsWorker
    include Sidekiq::Worker
    sidekiq_options retry: 5

    def perform
      Coin.pluck(:id) do |coin_id|
        Coins::SyncDailyPricesForCoinWorker(coin_id, 365, "USD")
      end
    end
  end
end
