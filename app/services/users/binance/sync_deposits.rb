module Users
  module Binance
    class SyncDeposits
      include Interactor

      delegate :user, to: :context

      def call
        deposits.each do |deposit|
          Users::Binance::CreateTransactionFromDeposit.call(deposit: deposit, user: user)
        end
      end

      private

      def deposits
        context.deposits ||= Users::Binance::FetchDepositHistory.call(user: user).deposit_history.deposits
      end
    end
  end
end
