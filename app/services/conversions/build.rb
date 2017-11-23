module Conversions
  class Build
    include Interactor

    delegate :receive_coin_id, :sending_coin_id, :user, to: :context

    def call
      conversion.tap do |c|
        conversion.rate = market_info["rate"]
        conversion.max_amount = market_info["limit"]
        conversion.min_amount = market_info["minimum"]
      end
    end

    private

    def conversion
      context.conversion ||= Conversion.new(
        receive_coin: receive_coin,
        sending_coin: sending_coin,
        user: user
      )
    end

    def receive_coin
      context.receive_coin ||= Coin.find(receive_coin_id)
    end

    def sending_coin
      context.sending_coin ||= Coin.find(sending_coin_id)
    end

    def market_info
      @market_info ||= Container[:shapeshift_client].market_info(pair: pair)
    end

    def pair
      context.pair ||= [sending_coin, receive_coin].map(&:symbol).map(&:downcase).join("_")
    end
  end
end
