module Users
  module Coinbase
    # @param [::Coinbase::Wallet::Transfer] received
    # @param [User] user
    class CreateTransactionFromReceived
      include Interactor

      delegate :user, :received, to: :context

      before do
        # Skip uncompleted transactions
        context.fail! if received["status"] != "completed"

        # Or if the type isn't send and received amount is greater than 0
        context.fail! if received.type != "send"
        context.fail! if get_amount(received).to_f <= 0
        # Or if we already processed this transaction
        context.fail! if ::Coinbase::Received.where(uuid: received["id"]).exists?
        context.fail! if coin.nil?
      end

      def call
        Rails.logger.debug "Received is #{received}"
        ActiveRecord::Base.transaction do
          context.transaction = user.transactions.create!(
            amount: BigDecimal.new(received["amount"]["amount"]),
            coin: coin,
            price: BigDecimal.new(received["native_amount"]["amount"]) / BigDecimal.new(received["amount"]["amount"]),
            transaction_type: :received,
            transaction_date: received["created_at"]
          )

          context.coinbase_received = context.transaction.create_coinbase_received!(
            uuid: received["id"],
            raw_data: received
          )
        end
      end

      private

      def coin
        context.coin ||= Coin.find_by(symbol: received["amount"]["currency"])
      end

      def get_amount(transaction)
        transaction["amount"]["amount"]
      end
    end
  end
end
