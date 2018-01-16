module Users
  module Binance
    # This is just a wrapper class to be able to perform the full Binance sync for all users
    class SyncDataForAllUsersWorker
      include Sidekiq::Worker

      sidekiq_options queue: "binance", retry: 5

      def perform
        User.find_each do |user|
          Users::Binance::SyncDepositsWorker.perform_async(user.id)
          Users::Binance::SyncWithdrawalsWorker.perform_async(user.id)
          Users::Binance::SyncOrdersWorker.perform_async(user.id)
        end
      end
    end
  end
end
