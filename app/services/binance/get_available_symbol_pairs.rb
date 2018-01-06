module Binance
  class GetAvailableSymbolPairs
    include Interactor

    def call
      context.symbol_pairs = client.all_prices.map { |price_info| price_info["symbol"] }
    end

    private

    def client
      @client ||= Binance::Client::REST.new
    end
  end
end
