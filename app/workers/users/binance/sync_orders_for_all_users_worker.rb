module Users
  module Binance
    class SyncOrdersForAllUsersWorker
      include Sidekiq::Worker

      sidekiq_options queue: "binance", retry: 5

      def perform
        User.find_each do |user|
          Users::Binance::SyncOrdersWorker.perform_async(user.id)
        end
      end
    end
  end
end
