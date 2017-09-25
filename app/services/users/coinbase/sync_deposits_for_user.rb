module Users
  module Coinbase
    class SyncDepositsForUser
      include Interactor
      include Client

      delegate :user, to: :context

      def call
        context.fail! if client.nil?

        client.accounts.each do |account|
          txs = client.transactions(account.id)

          txs.each do |deposit|
            Users::Coinbase::CreateTransactionFromDeposit.call(user: user, deposit: deposit)
          end
        end
      rescue ::Coinbase::Wallet::APIError => e
        Rails.logger.warn "Sync deposit failed. Coinbase::Wallet::APIError: #{e.message} user email: #{user.email}"
      end
    end
  end
end
