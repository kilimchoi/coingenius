module Users
  module Coinbase
    class SyncDataForAllUsersWorker
      include Sidekiq::Worker

      sidekiq_options queue: 'coinbase', retry: 5
      
      def perform
        User.find_each do |user|
          Users::Coinbase::SyncBuysForUserWorker.perform_async(user.id)
          Users::Coinbase::SyncSellsForUserWorker.perform_async(user.id)
          Users::Coinbase::SyncDepositsForUserWorker.perform_async(user.id)
          Users::Coinbase::SyncWithdrawalsForUserWorker.perform_async(user.id)
          Users::Coinbase::SyncReceivedForUserWorker.perform_async(user.id)
          Users::Coinbase::SyncSentForUserWorker.perform_async(user.id)
        end
      end
    end
  end
end
