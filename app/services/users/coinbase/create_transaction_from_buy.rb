module Users
  module Coinbase
    # @param [::Coinbase::Wallet::Transfer] buy
    # @param [User] user
    class CreateTransactionFromBuy
      include Interactor

      delegate :user, :buy, to: :context

      before do
        next if buy["status"] != "completed" # Skip uncompleted transactions
        next if ::Coinbase::Buy.where(uuid: buy["id"]).exists? # Or if we already processed this transaction
      end

      def call
        ActiveRecord::Base.transaction do
          context.transaction = user.transactions.create!(
            amount: BigDecimal.new(buy["amount"]["amount"]),
            coin: Coin.find_by(symbol: buy["amount"]["currency"]),
            price: BigDecimal.new(buy["subtotal"]["amount"]) / BigDecimal.new(buy["amount"]["amount"]),
            transaction_type: :bought
          )

          context.coinbase_buy = context.transaction.create_coinbase_buy!(
            uuid: buy["id"],
            raw_data: buy
          )
        end
      end
    end
  end
end
