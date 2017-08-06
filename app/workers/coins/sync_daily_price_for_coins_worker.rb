module Coins
  class SyncDailyPriceForCoinsWorker
    include Sidekiq::Worker
    sidekiq_options retry: 5

    def perform
      Coin.find_each do |coin| 
        SyncDailyPriceForCoinWorker.perform_async(coin.id)
      end
    end
  end
end
