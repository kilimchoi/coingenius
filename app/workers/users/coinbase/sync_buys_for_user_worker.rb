module Users
  module Coinbase
    class SyncBuysForUserWorker
      include Sidekiq::Worker

      def perform(user_id)
        user = User.find_by(user_id)

        Users::Coinbase::SyncBuysForUser.call(user: user) if user
      end
    end
  end
end
