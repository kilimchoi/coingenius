module Binance
  class DepositHistory
    attr_reader :history

    def initialize(history = {})
      @history = history
    end

    def symbols
      @symbols ||= history.map { |entry| entry["asset"] }.uniq
    end

    def deposits(symbol: nil)
      return history if symbol.blank?

      history.select { |deposit| deposit["asset"] == symbol }
    end
  end
end
