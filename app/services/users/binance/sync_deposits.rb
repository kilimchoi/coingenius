module Users
  module Binance
    class SyncDeposits
      include Interactor

      delegate :user, to: :context

      def call
        deposits.each do |deposit|
          result = Users::Binance::CreateTransactionFromDeposit.call(deposit: deposit, user: user)

          Rails.logger.warn("[#{self.class.name}]: Error - #{result.message}") if result.failure?
        end
      end

      private

      def deposits
        context.deposits ||= Users::Binance::FetchDepositHistory.call(user: user).deposit_history.deposits
      end
    end
  end
end
