module Users
  module Coinbase
    class SyncDepositsForUser
      include Interactor

      delegate :user, to: :context

      def call
        unless client.nil?
          client.accounts.each do |account|
            txs = client.transactions(account.id)

            txs.each do |deposit|
              Users::Coinbase::CreateTransactionFromDeposit.call(user: user, deposit: deposit)
            end
          end
        end
        nil
      rescue ::Coinbase::Wallet::APIError => e
        Rails.logger.warn "Sync deposit failed. Coinbase::Wallet::APIError: #{e.message} user email: #{user.email}"
        nil
      end

      private

      def client
        @client ||= Clients::CoinbaseClient.new(user: user).call
      end
    end
  end
end
