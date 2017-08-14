module Users
  module Bittrex
    class SyncOrdersForAllUsersWorker
      include Sidekiq::Worker

      def perform
        User.find_each do |user|
          SyncOrdersForUserWorker.perform_async(user.id)
        end
      end
    end
  end
end
