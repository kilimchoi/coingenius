module Coins
  # This service is responsible for getting historical close prices.
  # It will not include today's price.
  #
  # @param currency       [String]  Crypto-currency
  # @param days           [Integer] Historical days
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

    delegate :currency, :days, :price_currency, to: :context

    before do
      context.fail! if currency.blank? || days.blank? || price_currency.blank?
    end

    def call
      context.prices = response["Data"].map do |data|
        data.slice(:time, :close, :high, :low, :open).symbolize_keys
      end
    end

    private

    def response
      JSON.parse(HTTParty.get(url).body).with_indifferent_access
    end

    def url
      format(
        "https://min-api.cryptocompare.com/data/histoday?fsym=%s&tsym=%s&limit=%i&toTs=%i",
        currency.upcase,
        price_currency.upcase,
        days - 1,
        Date.today.to_time.to_i
      )
    end
  end
end
