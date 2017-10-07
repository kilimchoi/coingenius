module Users
  module Coinbase
    # @param [::Coinbase::Wallet::Transfer] buy
    # @param [User] user
    class CreateTransactionFromBuy
      include Interactor

      delegate :user, :buy, to: :context

      before do
        # Skip uncompleted transactions
        context.fail! if buy["status"] != "completed"

        # Or if we already processed this transaction
        context.fail! if ::Coinbase::Buy.where(uuid: buy["id"]).exists?
      end

      def call
        Rails.logger.debug "Buy is #{buy}"
        ActiveRecord::Base.transaction do
          context.transaction = user.transactions.create!(
            amount: BigDecimal.new(buy["amount"]["amount"]),
            coin: Coin.find_by(symbol: buy["amount"]["currency"]),
            price: BigDecimal.new(buy["subtotal"]["amount"]) / BigDecimal.new(buy["amount"]["amount"]),
            transaction_type: :bought,
            transaction_date: buy["created_at"]
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
