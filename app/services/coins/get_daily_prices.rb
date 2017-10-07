module Coins
  # This service is responsible for getting historical close prices.
  # It will not include today's price.
  #
  # @param coin           [Coin]
  # @param days           [Integer] Historical days
  # @param include_today  [Boolean] Include today's price
  # @param price_currency [String]  Price currency
  #
  # @example
  #   Get prices for ETH in USD up to 2 days (assuming we call the service at 20170802):
  #     ::Coins::GetDailyPrices.perform(currency: "USD", days: 2, symbol: "ETH").prices
  #   will return
  #     [
  #       {:time=>1504137600, :close=>388.33, :high=>389.64, :low=>380.89, :open=>383.86, :volumefrom=>335126.62, :volumeto=>129260777.23},
  #       {:time=>1504224000, :close=>391.42, :high=>395.3, :low=>386.71, :open=>388.33, :volumefrom=>491601.26, :volumeto=>192664622.13}
  #     ]
  class GetDailyPrices
    include Interactor

    delegate :coin, :days, :include_today, :price_currency, to: :context
    alias include_today? include_today

    before do
      context.fail! if coin.blank? || price_currency.blank?

      context.days = days.to_i > 0 ? days : 1
    end

    def call
      context.prices = response["Data"].map do |data|
        data.slice(:time, :close, :high, :low, :open).symbolize_keys
      end.last(days)
    end

    private

    def response
      JSON.parse(HTTParty.get(url).body).with_indifferent_access
    end

    def url
      up_to_date = include_today? ? Date.today : Date.yesterday

      format(
        "https://min-api.cryptocompare.com/data/histoday?fsym=%s&tsym=%s&limit=%i&toTs=%i",
        coin.symbol.upcase,
        price_currency.upcase,
        days,
        up_to_date.strftime("%s")
      )
    end
  end
end
