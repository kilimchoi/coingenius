module Coins
  # This service will get crypto-currencies supported by Shapeshift
  # and update every Coin in the DB setting appropriate status.
  class UpdateShapeshiftCompatibility
    include Interactor

    def call
      shapeshift_currencies.each do |symbol, info|
        coin = Coin.find_by(symbol: symbol)

        next if coin.nil?

        shapeshift_convertible = info["status"] == "available"

        coin.update(shapeshift_convertible: shapeshift_convertible)
      end
    end

    private

    def shapeshift_currencies
      Container[:shapeshift_client].coins
    end
  end
end
