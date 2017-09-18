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
        @client ||= Clients::CoinbaseClient.new(user: user).call
      end
    end
  end
end
