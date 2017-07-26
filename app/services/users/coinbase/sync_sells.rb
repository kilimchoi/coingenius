module Users
  module Coinbase
    class SyncSells
      include Interactor

      delegate :user, to: :context

      def call
        sells.each do |sell_transaction|
          user.transactions.create(
            amount: sell_transaction["amount"]["amount"],
            coin: Coin.find_by(symbol: sell_transaction["amount"]["currency"]),
            price: sell_transaction["subtotal"]["amount"] / sell_transaction["amount"]["amount"],
            transaction_type: :sold
          )
        end
      end

      private

      def buys
        client.primary_account.list_sells
      end

      def client
        @client ||= Coinbase::Wallet::OAuthClient.new(access_token: coinbase_identity.access_token)
      end

      def coinbase_identity
        @coinbase_identity ||= user.identity.find_by(provider: :coinbase)
      end
    end
  end
end
