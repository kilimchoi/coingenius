module Users
  module Bittrex
    class SyncOrders
      include Interactor

      delegate :user, to: :context

      def call
        client.order_history.each do |order|
          # Do not process orders in active state
          next if order.active?

          # And skip those we already processed
          next if BittrexOrder.where(uuid: order.id).exists?

          process_order(order)
        end
      end

      private

      # 0. Determine transaction type based on order type
      # 1. Create Transaction
      # 2. Create BittrexOrder for this transaction
      #
      # @param [Bittrex::Order] order
      def process_order(order)
        ActiveRecord::Base.transaction do
          transaction_type = order.sell? ? :sold : :bought
          coin_symbol = order.exchange.split("-").last

          transaction = user.transactions.create!(
            amount: BigDecimal.new(order.quantity, 12),
            coin: Coin.find_by!(symbol: coin_symbol),
            btc_price: order.price_per_unit,
            transaction_type: transaction_type
          )

          transaction.create_bittrex_order!(
            uuid: order.id,
            raw_data: order.raw
          )
        end
      end

      def client
        @client ||= ::Bittrex::Client.new(key: user.bittrex_api_key, secret: user.bittrex_api_secret)
      end
    end
  end
end
