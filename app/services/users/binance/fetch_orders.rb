module Users
  module Binance
    class FetchOrders
      include Interactor

      delegate :symbols, :user, to: :context

      before do
        context.symbols ||= []
      end

      def call
        latest_order_id = context.skip_existing ? (user.binance_orders.last&.uuid || 0) : 0

        context.orders = applicable_symbol_pairs.flat_map do |symbol_pair|
          Rails.logger.debug("#{[self.class.name]}: Fetching User##{user.id} orders for symbol pair #{symbol_pair}")

          client.all_orders(symbol: symbol_pair, orderId: latest_order_id)
        end
      end

      private

      def applicable_symbol_pairs
        @applicable_symbol_pairs ||= symbols.flat_map do |symbol|
          available_symbol_pairs.select { |symbol_pair| symbol_pair.include?(symbol) }
        end.uniq
      end

      def available_symbol_pairs
        @available_symbol_pairs ||= client.all_prices.map { |price_info| price_info["symbol"] }
      end

      def client
        @client ||= ::Binance::Client::REST.new(api_key: user.binance_api_key, secret_key: user.binance_api_secret)
      end
    end
  end
end
