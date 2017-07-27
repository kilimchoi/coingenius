module Users
  module Coinbase
    class SyncBuysForUser
      include Interactor

      delegate :user, to: :context

      def call
        buys.each do |buy_transaction|
          # Skip uncompleted transactions
          next if buy_transaction["status"] != "completed"

          # Or if we already processed this transaction
          next if ::Coinbase::Buy.where(uuid: buy_transaction["id"]).exists?

          process_transaction(buy_transaction)
        end
      end

      private

      def process_transaction(buy_transaction)
        transaction = user.transactions.create(
          amount: BigDecimal.new(buy_transaction["amount"]["amount"]),
          coin: Coin.find_by(symbol: buy_transaction["amount"]["currency"]),
          price: BigDecimal.new(buy_transaction["subtotal"]["amount"]) / BigDecimal(buy_transaction["amount"]["amount"]),
          transaction_type: :bought
        )

        transaction.create_coinbase_buy!(
          uuid: buy_transaction["id"],
          raw_data: buy_transaction
        )
      end

      def buys
        client.primary_account.list_buys
      end

      def client
        @client ||= ::Coinbase::Wallet::OAuthClient.new(access_token: coinbase_identity.access_token)
      end

      def coinbase_identity
        @coinbase_identity ||= user.identities.find_by(provider: :coinbase)
      end
    end
  end
end
