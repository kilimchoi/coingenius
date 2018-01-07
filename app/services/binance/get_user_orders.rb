module Binance
  class GetUserOrders
    include Interactor

    delegate :symbols, :user, to: :context

    def call
      context.orders = applicable_symbol_pairs.map do |symbol_pair|
        client.all_orders(symbol: symbol_pair)
      end.flatten
    end

    private

    def applicable_symbol_pairs
      @applicable_symbol_pairs ||= symbols.map do |symbol|
        available_symbol_pairs.select { |symbol_pair| symbol_pair.include?(symbol) }
      end.flatten.uniq
    end

    def available_symbol_pairs
      @available_symbol_pairs ||= Binance::GetAvailableSymbolPairs.call.symbol_pairs
    end

    def client
      @client ||= Binance::Client::REST.new(api_key: user.binance_api_key, secret_key: user.binance_api_secret)
    end
  end
end
