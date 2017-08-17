module Coins
  class SyncDailyPriceForCoinsWorker
    include Sidekiq::Worker
    sidekiq_options retry: 5

    def perform
      Coin.find_each do |coin| 
        Coins::SyncDailyPriceForCoinWorker.perform_async(coin.id)
        sleep 1
      end
    end
  end
end
