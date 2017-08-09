module Users
  module Bittrex
    class SyncWithdrawals
      include Interactor

      delegate :user, to: :context

      def call
        client.withdrawals.each do |withdrawal|
          # TODO
          # 1. Next if deposit already created by uuid
          # 2. Create BittrexWithdrawal
          # 3. Create Transaction
          # 4. Associate BittrexWithdrawal and Transaction
        end
      end

      private

      def client
        @client ||= Bittrex::Client.new(key: user.bittrex_api_key, secret: user.bittrex_api_secret)
      end
    end
  end
end
