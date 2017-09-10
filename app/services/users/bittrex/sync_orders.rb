module Users
  module Bittrex
    class SyncOrders
      include Interactor

      delegate :user, to: :context

      def call
        begin
          client.order_history.each do |order|
            # Do not process orders in active state
            next if order.active?

            BittrexOrders::CreateFromOrder.call(order: order, user: user)
          end
        rescue ::Bittrex::Client::BaseError => e
          # Do nothing, but fail interactor.
          #
          # Initial idea was to purge Bittrex API key and secret but it may be excessive for now.
          # I am not sure if we want to force user to update his API keys in case of Bittrex API failures.
          Rails.logger.warn "Bittrex SyncOrders failed. Message: #{e.message} user email: #{user.email}"
          context.fail!
        end
      end

      private

      # 0. Determine transaction type based on order type
      # 1. Create Transaction
      # 2. Create BittrexOrder for this transaction
      #
      # @param [Bittrex::Order] order
      def process_order(order)

      end

      def client
        @client ||= ::Bittrex::Client.new(key: user.bittrex_api_key, secret: user.bittrex_api_secret)
      end
    end
  end
end
