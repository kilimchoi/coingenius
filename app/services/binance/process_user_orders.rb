module Binance
  class ProcessUserOrders
    include Interactor

    delegate :user, to: :context

    def call
      orders.each do |order|
        Binance::Orders::Create.call(order: order, user: user)
      end
    end

    private

    def orders
      context.orders ||= Binance::GetUserOrders.call(symbols: user_symbols, user: user).orders
    end

    def user_symbols
      context.symbols ||= Binance::GetUserDepositHistory.call(user: user).deposit_history.symbols
    end
  end
end
