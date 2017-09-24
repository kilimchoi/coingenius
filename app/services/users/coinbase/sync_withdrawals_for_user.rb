module Users
  module Coinbase
    class SyncWithdrawalsForUser
      include Interactor

      delegate :user, to: :context

      def call
        unless client.nil?
          client.accounts.each do |account|
            txs = client.transactions(account.id)

            txs.each do |withdrawal|
              Users::Coinbase::CreateTransactionFromWithdrawal.call(user: user, withdrawal: withdrawal)
            end
          end
        end
        nil
      rescue ::Coinbase::Wallet::APIError => e
        Rails.logger.warn "Sync withdrawal failed. Coinbase::Wallet::APIError: #{e.message} user email: #{user.email}"
        nil
      end

      private

      def client
        @client ||= Clients::CoinbaseClient.new(user).call
      end
    end
  end
end
