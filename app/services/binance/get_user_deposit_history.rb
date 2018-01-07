module Binance
  class GetUserDepositHistory
    include Interactor

    delegate :user, to: :context

    def call
      context.deposit_history = Binance::DepositHistory.new(client.deposit_history["depositList"])
    end

    private

    def client
      @client ||= Binance::Client::REST.new(api_key: user.binance_api_key, secret_key: user.binance_api_secret)
    end
  end
end
