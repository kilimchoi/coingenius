module Users
  module Binance
    # This service creates an Binance::Deposit along with a transaction from the JSON object returned via Binance API.
    class CreateTransactionFromDeposit
      include Interactor

      delegate :deposit, :user, to: :context

      before do
        Rails.logger.debug("[#{self.class.name}]: Creating Binance::Deposit from #{deposit.inspect}")

        context.fail!(message: "Deposit is not finished") if deposit["status"] != 1
        context.fail!(message: "Already exists") if already_exists?
        context.fail!(message: "Coin is not supported") if coin.nil?
      end

      def call
        ActiveRecord::Base.transaction do
          context.transaction = user.transactions.create!(
            amount: amount,
            coin: coin,
            transaction_date: executed_at,
            transaction_type: :deposit
          )

          context.binance_order = context.transaction.create_binance_deposit!(
            executed_at: executed_at,
            raw_data: deposit,
            uuid: deposit["txId"]
          )
        end
      end

      private

      def amount
        BigDecimal.new(deposit["amount"], 12)
      end

      def already_exists?
        ::Binance::Deposit.exists?(uuid: deposit["txId"])
      end

      def coin
        @coin ||= Coin.find_by(symbol: deposit["asset"])
      end

      def executed_at
        @executed_at ||= Time.at(deposit["insertTime"] / 1000).utc.to_datetime
      end
    end
  end
end
