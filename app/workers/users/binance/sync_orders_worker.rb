module Users
  module Binance
    class SyncOrdersWorker
      include Sidekiq::Worker

      sidekiq_options retry: 5

      def perform(user_id)
        user = User.find_by(id: user_id)

        return unless user&.binance_api_key && user&.binance_api_secret

        Users::Binance::SyncOrders.call(user: user)
      end
    end
  end
end
