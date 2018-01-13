module Users
  module Binance
    # This service creates an Binance::Order along with a transaction from the JSON object returned via Binance API.
    class CreateTransactionFromOrder
      include Interactor

      delegate :order, :user, to: :context

      before do
        Rails.logger.debug("[#{self.class.name}]: Creating Binance::Order from #{order.inspect}")

        context.fail!(message: "Order status is not FILLED") if order["status"] != "FILLED"
        context.fail!(message: "Already exists") if already_exists?
        context.fail!(message: "Coin is not supported") if coin.nil?
      end

      def call
        ActiveRecord::Base.transaction do
          context.transaction = user.transactions.create!(
            amount: amount,
            coin: coin,
            converted_coin: Coin.find_by(symbol: converted_coin_symbol),
            converted_coin_price: price,
            transaction_date: executed_at,
            transaction_type: transaction_type
          )

          context.linked_transaction = user.transactions.create!(
            amount: converted_coin_amount,
            coin: converted_coin,
            converted_coin: coin,
            converted_coin_price: converted_coin_price,
            linked_transaction: context.transaction,
            transaction_date: executed_at,
            transaction_type: linked_transaction_type
          )

          context.transaction.update!(linked_transaction: context.linked_transaction)

          context.binance_order = context.transaction.create_binance_order!(
            executed_at: executed_at,
            raw_data: order,
            uuid: order["orderId"]
          )
        end
      end

      private

      def price
        @price ||= BigDecimal.new(order["price"], 12)
      end

      def amount
        @amount ||= BigDecimal.new(order["origQty"], 12)
      end

      def already_exists?
        ::Binance::Order.exists?(uuid: order["orderId"])
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
        order["side"] == "SELL" ? :sold : :bought
      end

      # Converted coin methods

      def converted_coin
        Coin.find_by(symbol: converted_coin_symbol)
      end

      def converted_coin_amount
        @converted_coin_amount ||= amount * price
      end

      def converted_coin_symbol
        Coin.pluck(:symbol).find { |symbol| order["symbol"].end_with?(symbol) }
      end

      def converted_coin_price
        amount / converted_coin_amount
      end

      def linked_transaction_type
        order["side"] == "SELL" ? :bought : :sold
      end
    end
  end
end
