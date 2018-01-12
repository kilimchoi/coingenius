module Users
  module Bittrex
    class SyncOrdersForUserWorker
      include Sidekiq::Worker

      sidekiq_options queue: 'bittrex', retry: 5

      def perform(user_id)
        user = User.find_by(id: user_id)

        return unless user&.bittrex_api_key && user&.bittrex_api_secret

        Users::Bittrex::SyncOrders.call(user: user)
      end
    end
  end
end
