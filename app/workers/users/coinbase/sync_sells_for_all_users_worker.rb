module Users
  module Coinbase
    class SyncSellsForAllUsersWorker
      include Sidekiq::Worker

      def perform
        User.find_each do |user|
          SyncSellsForUserWorker.perform_async(user_id: user.id)
        end
      end
    end
  end
end
