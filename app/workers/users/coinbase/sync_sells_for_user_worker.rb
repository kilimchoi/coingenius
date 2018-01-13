module Users
  module Coinbase
    class SyncSellsForUserWorker
      include Sidekiq::Worker

      sidekiq_options queue: "coinbase", retry: 5

      def perform(user_id)
        user = User.find_by(id: user_id)

        Users::Coinbase::SyncSellsForUser.call(user: user) if user
      end
    end
  end
end
