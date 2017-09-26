module Users
  module Coinbase
    # @param [::Coinbase::Wallet::Transfer] deposit
    # @param [User] user
    class CreateTransactionFromDeposit
      include Interactor

      delegate :user, :deposit, to: :context

      before do
        # Skip uncompleted transactions
        context.fail! if deposit["status"] != "completed"

        # Or if the type isn't exchange_deposit and deposit amount is greater than 0
        context.fail! if deposit.type != "exchange_deposit"
        context.fail! if deposit["amount"]["currency"] == "USD"
        # Or if we already processed this transaction
        context.fail! if ::Coinbase::Deposit.where(uuid: deposit["id"]).exists?
      end

      def call
        ActiveRecord::Base.transaction do
          context.transaction = user.transactions.create!(
            amount: BigDecimal.new(deposit["amount"]["amount"]) * -1,
            coin: Coin.find_by(symbol: deposit["amount"]["currency"]),
            price: BigDecimal.new(deposit["native_amount"]["amount"]) / BigDecimal.new(deposit["amount"]["amount"]),
            transaction_type: :deposit, 
            transaction_date: deposit["created_at"]
          )

          context.coinbase_deposit = context.transaction.create_coinbase_deposit!(
            uuid: deposit["id"],
            raw_data: deposit
          )
        end
      end

      private

      def get_amount(transaction)
        transaction.amount.amount
      end
    end
  end
end
