module Users
  module Coinbase
    class SyncSellsForUser
      include Interactor

      delegate :user, to: :context

      def call
        unless client.nil?
          client.accounts.each do |account|
            sells = client.list_sells(account.id)

            sells.each do |sell_transaction|
              Users::Coinbase::CreateTransactionFromSell.call(user: user, sell: sell_transaction)
            end
          end
        end
        nil
      rescue ::Coinbase::Wallet::APIError => e
        Rails.logger.warn "Sync sell failed. Coinbase::Wallet::APIError: #{e.message} user email: #{user.email}"
        nil
      end

      private

      def client
        @client ||= Clients::CoinbaseClient.new(user).call
      end
    end
  end
end
