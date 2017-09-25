module Users
  module Coinbase
    class SyncWithdrawalsForUser
      include Interactor
      include Client

      delegate :user, to: :context

      def call
        context.fail! if client.nil?

        client.accounts.each do |account|
          txs = client.transactions(account.id)

          txs.each do |withdrawal|
            Users::Coinbase::CreateTransactionFromWithdrawal.call(user: user, withdrawal: withdrawal)
          end
        end
      rescue ::Coinbase::Wallet::APIError => e
        Rails.logger.warn "Sync withdrawal failed. Coinbase::Wallet::APIError: #{e.message} user email: #{user.email}"
      end
    end
  end
end
