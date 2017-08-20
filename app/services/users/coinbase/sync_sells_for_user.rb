module Users
  module Coinbase
    class SyncSellsForUser
      include Interactor

      delegate :user, to: :context

      def call
        client.accounts.each do |account|
          sells = client.list_sells(account.id)

          sells.each do |sell_transaction|
            Users::Coinbase::CreateTransactionFromSell.call(user: user, sell: sell_transaction)
          end
        end
      end

      private

      def client
        @client ||= ::Coinbase::Wallet::OAuthClient.new(access_token: coinbase_identity.access_token)
      end

      def coinbase_identity
        @coinbase_identity ||= user.identities.find_by(provider: :coinbase)
      end
    end
  end
end
