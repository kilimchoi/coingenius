module Users
  module Coinbase
    class SyncSentForUser
      include Interactor
      include Client

      delegate :user, to: :context

      def call
        context.fail! if client.nil?

        client.accounts.each do |account|
          txs = client.transactions(account.id)

          txs.each do |sent|
            Users::Coinbase::CreateTransactionFromSent.call(user: user, sent: sent)
          end
        end
      rescue ::Coinbase::Wallet::APIError => e
        Rails.logger.warn "Sync sent failed. Coinbase::Wallet::APIError: #{e.message} user email: #{user.email}"
      end
    end
  end
end
