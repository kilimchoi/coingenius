module BittrexOrders
  # This service creates an BittrexOrder along with a transaction from a ::Bittrex::Order instance.
  # Naming is a bit funky though.
  class CreateFromOrder
    include Interactor

    delegate :order, :user, to: :context

    def call
      ActiveRecord::Base.transaction do
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

    private

    def coin_symbol
      context.coin_symbol ||= begin
        symbol = order.exchange.split("-").last

        symbol == "BCC" ? "BCH" : symbol
      end
    end

    def transaction_type
      context.transaction_type ||= order.sell? ? :sold : :bought
    end
  end
end
