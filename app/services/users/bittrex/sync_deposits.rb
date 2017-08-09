module Users
  module Bittrex
    class SyncDeposits
      include Interactor

      delegate :user, to: :context

      def call
        client.deposits.each do |deposit|
          # TODO
          # 1. Next if deposit already created by uuid
          # 2. Create BittrexDeposit
          # 3. Create Transaction
          # 4. Associate BittrexDeposit and Transaction
        end
      end

      private

      def client
        @client ||= Bittrex::Client.new(key: user.bittrex_api_key, secret: user.bittrex_api_secret)
      end
    end
  end
end
