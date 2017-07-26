module Users
  module Coinbase
    class SyncSells
      include Interactor

      delegate :user, to: :context

      def call
        sells.each do |sell_transaction|
          user.transactions.create(
            amount: BigDecimal.new(sell_transaction["amount"]["amount"]),
            coin: Coin.find_by(symbol: sell_transaction["amount"]["currency"]),
            price: BigDecimal.new(sell_transaction["subtotal"]["amount"]) / BigDecimal.new(sell_transaction["amount"]["amount"]),
            transaction_type: :sold
          )
        end
      end

      private

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
