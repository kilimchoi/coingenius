module Users
  module Binance
    class SyncOrders
      include Interactor

      delegate :user, to: :context

      def call
        orders.each do |order|
          Users::Binance::CreateTransactionFromOrder.call(order: order, user: user)
        end
      end

      private

      def orders
        context.orders ||= Users::Binance::FetchOrders.call(symbols: user_symbols, user: user).orders
      end

      def user_symbols
        context.symbols ||= Users::Binance::FetchDepositHistory.call(user: user).deposit_history.symbols
      end
    end
  end
end
