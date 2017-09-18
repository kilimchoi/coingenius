module Users
  module Coinbase
    class SyncReceivedForAllUsersWorker
      include Sidekiq::Worker

      def perform
        User.find_each do |user|
          SyncReceivedForUserWorker.perform_async(user.id)
        end
      end
    end
  end
end
