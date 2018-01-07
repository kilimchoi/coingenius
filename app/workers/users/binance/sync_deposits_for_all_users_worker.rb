module Users
  module Binance
    class SyncDepositsForAllUsersWorker
      include Sidekiq::Worker

      def perform
        User.find_each do |user|
          Users::Binance::SyncDepositsWorker.perform_async(user.id)
        end
      end
    end
  end
end
