module Users
  module Coinbase
    class SyncSentForUser
      include Interactor

      delegate :user, to: :context

      def call
        unless client.nil?
          client.accounts.each do |account|
            txs = client.transactions(account.id)

            txs.each do |sent|
              Users::Coinbase::CreateTransactionFromSent.call(user: user, sent: sent)
            end
          end
        end
        nil
      rescue ::Coinbase::Wallet::APIError => e
        Rails.logger.warn "Sync sent failed. Coinbase::Wallet::APIError: #{e.message} user email: #{user.email}"
        nil
      end

      private

      def client
        @client ||= Clients::CoinbaseClient.new(user: user).call
      end
    end
  end
end
