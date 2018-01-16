module Users
  module Binance
    class SyncWithdrawalsForAllUsersWorker
      include Sidekiq::Worker

      sidekiq_options queue: "binance", retry: 5

      def perform
        User.find_each do |user|
          Users::Binance::SyncWithdrawalsWorker.perform_async(user.id)
        end
      end
    end
  end
end
