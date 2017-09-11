module BittrexOrders
  # This service creates an BittrexOrder along with a transaction from a ::Bittrex::Order instance.
  # Naming is a bit funky though.
  class CreateFromOrder
    include Interactor

    delegate :order, :user, to: :context

    before do
      context.fail!(message: "Already exists") if already_exists?
    end

    def call
      ActiveRecord::Base.transaction do
        context.transaction = user.transactions.create!(
          amount: BigDecimal.new(order.quantity, 12),
          coin: Coin.find_by!(symbol: coin_symbol),
          btc_price: order.price_per_unit,
          transaction_type: transaction_type
        )

        context.bittrex_order = context.transaction.create_bittrex_order!(
          closed_at: order.closed_at,
          executed_at: order.executed_at,
          raw_data: order.raw,
          uuid: order.id
        )
      end
    end

    private

    def already_exists?
      BittrexOrder.exists?(uuid: order.id)
    end

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
