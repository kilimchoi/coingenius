module Users
  module Coinbase
    class SyncReceivedForUser
      include Interactor

      delegate :user, to: :context

      def call
        unless client.nil?
          client.accounts.each do |account|
            txs = client.transactions(account.id)

            txs.each do |received|
              Users::Coinbase::CreateTransactionFromReceived.call(user: user, received: received)
            end
          end
        end
        nil
      rescue ::Coinbase::Wallet::APIError => e
        Rails.logger.warn "Sync received failed. Coinbase::Wallet::APIError: #{e.message} user email: #{user.email}"
        nil
      end

      private

      def client
        @client ||= Clients::CoinbaseClient.new(user).call
      end
    end
  end
end
