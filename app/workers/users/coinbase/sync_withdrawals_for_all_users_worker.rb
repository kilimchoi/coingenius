module Users
  module Coinbase
    class SyncWithdrawalsForAllUsersWorker
      include Sidekiq::Worker

      def perform
        User.find_each do |user|
          SyncWithdrawalsForUserWorker.perform_async(user.id)
        end
      end
    end
  end
end
