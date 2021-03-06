module Users
  module Coinbase
    # @param [::Coinbase::Wallet::Transfer] withdrawal
    # @param [User] user
    class CreateTransactionFromWithdrawal
      include Interactor

      delegate :user, :withdrawal, to: :context

      before do
        # Skip uncompleted transactions
        context.fail! if withdrawal["status"] != "completed"

        # Or if the type isn't exchange_withdrawal and withdrawal amount is greater than 0
        context.fail! if withdrawal.type != "exchange_withdrawal"

        context.fail! if withdrawal["amount"]["currency"] == "USD"
        # Or if we already processed this transaction
        context.fail! if ::Coinbase::Withdrawal.where(uuid: withdrawal["id"]).exists?
        context.fail! if coin.nil?
      end

      def call
        Rails.logger.debug "Withdrawal is #{withdrawal}"
        ActiveRecord::Base.transaction do
          context.transaction = user.transactions.create!(
            amount: BigDecimal.new(withdrawal["amount"]["amount"]),
            coin: coin,
            price: BigDecimal.new(withdrawal["native_amount"]["amount"]) / BigDecimal.new(withdrawal["amount"]["amount"]),
            transaction_type: :withdrawal,
            transaction_date: withdrawal["created_at"]
          )

          context.coinbase_withdrawal = context.transaction.create_coinbase_withdrawal!(
            uuid: withdrawal["id"],
            raw_data: withdrawal
          )
        end
      end

      private

      def coin
        context.coin ||= Coin.find_by(symbol: withdrawal["amount"]["currency"])
      end
    end
  end
end
