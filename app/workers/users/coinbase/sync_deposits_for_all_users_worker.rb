module Users
  module Coinbase
    class SyncDepositsForAllUsersWorker
      include Sidekiq::Worker

      def perform
        User.find_each do |user|
          SyncDepositsForUserWorker.perform_async(user.id)
        end
      end
    end
  end
end
