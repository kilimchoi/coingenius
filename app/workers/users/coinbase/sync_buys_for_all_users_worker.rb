module Users
  module Coinbase
    class SyncBuysForAllUsersWorker
      include Sidekiq::Worker

      def perform
        User.find_each do |user|
          SyncBuysForUserWorker.perform_async(user.id)
        end
      end
    end
  end
end
