module Binance
  module Orders
    # This service creates an Binance::Order along with a transaction from the JSON object returned via Binance API.
    class Create
      include Interactor

      delegate :order, :user, to: :context

      before do
        Rails.logger.debug("[#{self.class.name}]: Creating Binance::Order from #{order.inspect}")

        context.fail!(message: "Already exists") if already_exists? || coin.nil?
      end

      def call
        ActiveRecord::Base.transaction do
          context.transaction = user.transactions.create!(
            amount: amount,
            coin: coin,
            transaction_date: executed_at,
            transaction_type: transaction_type
          )

          context.binance_order = context.transaction.create_binance_order!(
            executed_at: executed_at,
            raw_data: order,
            uuid: order["orderId"]
          )
        end
      end

      private

      def amount
        BigDecimal.new(order["origQty"], 12)
      end

      def already_exists?
        Binance::Order.exists?(uuid: order["orderId"])
      end

      def coin
        @coin ||= Coin.find_by(symbol: coin_symbol)
      end

      def coin_symbol
        Coin.pluck(:symbol).find { |symbol| order["symbol"].start_with?(symbol) }
      end

      def executed_at
        @executed_at ||= Time.at(order["time"] / 1000).utc.to_datetime
      end

      def transaction_type
        order["side"] ? :sold : :bought
      end
    end
  end
end
