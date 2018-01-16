module Users
  module Binance
    class SyncDataWorker
      include Sidekiq::Worker

      sidekiq_options queue: "binance", retry: 5

      def perform(user_id)
        Users::Binance::SyncDepositsWorker.perform_async(user_id)
        Users::Binance::SyncWithdrawalsWorker.perform_async(user_id)
        Users::Binance::SyncOrdersWorker.perform_async(user_id)
      end
    end
  end
end
