module Users
  module Coinbase
    # @param [::Coinbase::Wallet::Transfer] sent
    # @param [User] user
    class CreateTransactionFromSent
      include Interactor

      delegate :user, :sent, to: :context

      before do
        # Skip uncompleted transactions
        context.fail! if sent["status"] != "completed"
        # Or if the type isn't send and sent amount is greater than 0
        context.fail! if sent.type != "send"
        context.fail! if get_amount(sent).to_f > 0
        context.fail! if sent["amount"]["currency"] == "USD"
        # Or if we already processed this transaction
        context.fail! if ::Coinbase::Sent.where(uuid: sent["id"]).exists?
      end

      def call
        Rails.logger.debug "Sent is #{sent}"
        ActiveRecord::Base.transaction do
          context.transaction = user.transactions.create!(
            amount: BigDecimal.new(sent["amount"]["amount"]) * -1,
            coin: Coin.find_by(symbol: sent["amount"]["currency"]),
            price: BigDecimal.new(sent["native_amount"]["amount"]) / BigDecimal.new(sent["amount"]["amount"]),
            transaction_type: :sent, 
            transaction_date: sent["created_at"]
          )

          context.coinbase_sent = context.transaction.create_coinbase_sent!(
            uuid: sent["id"],
            raw_data: sent
          )
        end
      end

      private

      def get_amount(transaction)
        transaction["amount"]["amount"]
      end
    end
  end
end
