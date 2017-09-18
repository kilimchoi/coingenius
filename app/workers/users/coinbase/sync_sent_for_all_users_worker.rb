module Users
  module Coinbase
    class SyncSentForAllUsersWorker
      include Sidekiq::Worker

      def perform
        User.find_each do |user|
          SyncSentForUserWorker.perform_async(user.id)
        end
      end
    end
  end
end
