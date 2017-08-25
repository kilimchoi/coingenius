module Users
  module Coinbase
    class SyncSellsForUser
      include Interactor

      delegate :user, to: :context

      def call
        unless client
          client.accounts.each do |account|
            sells = client.list_sells(account.id)

            sells.each do |sell_transaction|
              Users::Coinbase::CreateTransactionFromSell.call(user: user, sell: sell_transaction)
            end
          end
        end
        nil
      end

      private

      def client
        @client ||= ::Coinbase::Wallet::OAuthClient.new(access_token: coinbase_identity.access_token) unless coinbase_identity.nil?
      end

      def coinbase_identity
        @coinbase_identity ||= user.identities.find_by(provider: :coinbase)
      end
    end
  end
end
