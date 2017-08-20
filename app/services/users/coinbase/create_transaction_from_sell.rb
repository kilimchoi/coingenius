module Users
  module Coinbase
    # @param [::Coinbase::Wallet::Transfer] sell
    # @param [User] user
    class CreateTransactionFromSell
      include Interactor

      delegate :user, :sell, to: :context

      before do
        next if sell["status"] != "completed" # Skip uncompleted transactions
        next if ::Coinbase::Sell.where(uuid: sell["id"]).exists? # Or if we already processed this transaction
      end

      def call
        ActiveRecord::Base.transaction do
          context.transaction = user.transactions.create!(
            amount: BigDecimal.new(sell["amount"]["amount"]),
            coin: Coin.find_by(symbol: sell["amount"]["currency"]),
            price: BigDecimal.new(sell["subtotal"]["amount"]) / BigDecimal.new(sell["amount"]["amount"]),
            transaction_type: :sold
          )

          context.coinbase_sell = context.transaction.create_coinbase_sell!(
            uuid: sell["id"],
            raw_data: sell
          )
        end
      end
    end
  end
end
