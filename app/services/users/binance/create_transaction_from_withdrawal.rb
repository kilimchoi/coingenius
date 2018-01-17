module Users
  module Binance
    # This service creates an Binance::Withdrawal along with a transaction from the JSON object returned via Binance API.
    class CreateTransactionFromWithdrawal
      include Interactor

      delegate :withdrawal, :user, to: :context

      before do
        Rails.logger.debug("[#{self.class.name}]: Creating Binance::Withdrawal from #{withdrawal.inspect}")

        context.fail!(message: "Withdrawal is not finished") if withdrawal["status"] != 6
        context.fail!(message: "Already exists") if already_exists?
        context.fail!(message: "Coin is not supported") if coin.nil?
      end

      def call
        ActiveRecord::Base.transaction do
          context.transaction = user.transactions.create!(
            amount: amount,
            coin: coin,
            transaction_date: executed_at,
            transaction_type: :withdrawal
          )

          context.binance_order = context.transaction.create_binance_withdrawal!(
            executed_at: executed_at,
            raw_data: withdrawal,
            uuid: withdrawal["txId"]
          )
        end
      end

      private

      def amount
        BigDecimal.new(withdrawal["amount"], 12)
      end

      def already_exists?
        ::Binance::Withdrawal.exists?(uuid: withdrawal["txId"])
      end

      def coin
        @coin ||= Coin.find_by(symbol: coin_symbol)
      end

      def coin_symbol
        withdrawal["asset"] == "BCC" ? "BCH" : withdrawal["asset"]
      end

      def executed_at
        @executed_at ||= Time.at(withdrawal["applyTime"] / 1000).utc.to_datetime
      end
    end
  end
end
