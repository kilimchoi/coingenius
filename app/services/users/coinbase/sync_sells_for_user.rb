module Users
  module Coinbase
    class SyncSellsForUser
      include Interactor
      include Client

      delegate :user, to: :context

      def call
        context.fail! if client.nil?
        client.accounts.each do |account|
          sells = client.list_sells(account.id)

          sells.each do |sell_transaction|
            Users::Coinbase::CreateTransactionFromSell.call(user: user, sell: sell_transaction)
          end
        end
      rescue ::Coinbase::Wallet::APIError => e
        Rails.logger.warn "Sync sell failed. Coinbase::Wallet::APIError: #{e.message} user email: #{user.email}"
      end
    end
  end
end
