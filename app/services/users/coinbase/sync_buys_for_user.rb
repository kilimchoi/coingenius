module Users
  module Coinbase
    class SyncBuysForUser
      include Interactor

      delegate :user, to: :context

      def call 
        unless client.nil?
          client.accounts.each do |account|
            buys = client.list_buys(account.id)

            buys.each do |buy_transaction|
              Users::Coinbase::CreateTransactionFromBuy.call(user: user, buy: buy_transaction)
            end
          end
        end
        nil
      rescue ::Coinbase::Wallet::APIError => e
        Rails.logger.warn "Sync buy failed. Coinbase::Wallet::APIError: #{e.message} user email: #{user.email}"
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
