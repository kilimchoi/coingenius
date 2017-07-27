module Users
  module Coinbase
    class SyncSellsForUserWorker
      include Sidekiq::Worker

      def perform(user_id)
        user = User.find_by(user_id)

        Users::Coinbase::SyncSellsForUser.call(user: user) if user
      end
    end
  end
end
