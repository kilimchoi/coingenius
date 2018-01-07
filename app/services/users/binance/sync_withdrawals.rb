module Users
  module Binance
    class SyncWithdrawals
      include Interactor

      delegate :user, to: :context

      def call
        withdrawals.each do |withdrawal|
          result = Users::Binance::CreateTransactionFromWithdrawal.call(withdrawal: withdrawal, user: user)

          Rails.logger.warn("[#{self.class.name}]: Error - #{result.message}") if result.failure?
        end
      end

      private

      def client
        @client ||= ::Binance::Client::REST.new(api_key: user.binance_api_key, secret_key: user.binance_api_secret)
      end

      def withdrawals
        context.withdrawals ||= client.withdraw_history["withdrawList"]
      end
    end
  end
end
