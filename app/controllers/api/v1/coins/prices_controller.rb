module Api
  module V1
    module Coins
      class PricesController < Api::V1::ApplicationController
        respond_to :json

        expose :coin
        expose :prices, -> {
          ::Coins::GetCachedPriceHistory.call(coin: coin, days: 365, price_currency: "USD").results
        }

        def index
          render json: prices
        end
      end
    end
  end
end
