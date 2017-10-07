module Users
  module Coinbase
    class SyncBuysForUser
      include Interactor
      include Client

      delegate :user, to: :context

      def call
        context.fail! if client.nil?

        client.accounts.each do |account|
          buys = client.list_buys(account.id)

          buys.each do |buy_transaction|
            Users::Coinbase::CreateTransactionFromBuy.call(user: user, buy: buy_transaction)
          end
        end
      rescue ::Coinbase::Wallet::APIError => e
        Rails.logger.warn "Sync buy failed. Coinbase::Wallet::APIError: #{e.message} user email: #{user.email}"
      end
    end
  end
end
