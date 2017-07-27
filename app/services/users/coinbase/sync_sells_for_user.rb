module Users
  module Coinbase
    class SyncSellsForUser
      include Interactor

      delegate :user, to: :context

      def call
        sells.each do |sell_transaction|
          # Skip uncompleted transactions
          next if sell_transaction["status"] != "completed"

          # Or if we already processed this transaction
          next if ::Coinbase::Sell.where(uuid: sell_transaction["id"]).exists?

          process_transaction(sell_transaction)
        end
      end

      private

      def process_transaction(sell_transaction)
        transaction = user.transactions.create!(
          amount: BigDecimal.new(sell_transaction["amount"]["amount"]),
          coin: Coin.find_by(symbol: sell_transaction["amount"]["currency"]),
          price: BigDecimal.new(sell_transaction["subtotal"]["amount"]) / BigDecimal.new(sell_transaction["amount"]["amount"]),
          transaction_type: :sold
        )

        transaction.create_coinbase_sell!(
          uuid: sell_transaction["id"],
          raw_data: sell_transaction
        )
      end

      def sells
        client.primary_account.list_sells
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
