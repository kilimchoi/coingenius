module Users
  module Coinbase
    # @param [::Coinbase::Wallet::Transfer] sell
    # @param [User] user
    class CreateTransactionFromSell
      include Interactor

      delegate :user, :sell, to: :context

      before do
        # Skip uncompleted transactions
        context.fail! if sell["status"] != "completed"

        # Or if we already processed this transaction
        context.fail! if ::Coinbase::Sell.where(uuid: sell["id"]).exists?
        context.fail! if coin.nil?
      end

      def call
        Rails.logger.debug "Sell is #{sell}"
        ActiveRecord::Base.transaction do
          context.transaction = user.transactions.create!(
            amount: BigDecimal.new(sell["amount"]["amount"]),
            coin: coin,
            price: BigDecimal.new(sell["subtotal"]["amount"]) / BigDecimal.new(sell["amount"]["amount"]),
            transaction_type: :sold,
            transaction_date: sell["created_at"]
          )

          context.coinbase_sell = context.transaction.create_coinbase_sell!(
            uuid: sell["id"],
            raw_data: sell
          )
        end
      end

      private

      def coin
        context.coin ||= Coin.find_by(symbol: sell["amount"]["currency"])
      end
    end
  end
end
