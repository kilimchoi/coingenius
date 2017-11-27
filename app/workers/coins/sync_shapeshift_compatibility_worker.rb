module Coins
  class SyncShapeshiftCompatibilityWorker
    include Sidekiq::Worker
    sidekiq_options retry: 5

    def perform
      Coins::UpdateShapeshiftCompatibility.call
    end
  end
end
