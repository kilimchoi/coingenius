module Users
  module Coinbase
    class SyncSentForUserWorker
      include Sidekiq::Worker

      sidekiq_options queue: "coinbase", retry: 5

      def perform(user_id)
        user = User.find_by(id: user_id)

        Users::Coinbase::SyncSentForUser.call(user: user) if user
      end
    end
  end
end
