module Users
  module Coinbase
    class SyncReceivedForUser
      include Interactor
      include Client

      delegate :user, to: :context

      def call
        context.fail! if client.nil?

        client.accounts.each do |account|
          txs = client.transactions(account.id)

          txs.each do |received|
            Users::Coinbase::CreateTransactionFromReceived.call(user: user, received: received)
          end
        end
      rescue ::Coinbase::Wallet::APIError => e
        Rails.logger.warn "Sync received failed. Coinbase::Wallet::APIError: #{e.message} user email: #{user.email}"
        nil
      end
    end
  end
end
