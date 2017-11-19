class ConversionFactory
  attr_reader :conversion

  def initialize(receive_coin_id:, sending_coin_id:, user:)
    @receive_coin_id = receive_coin_id
    @sending_coin_id = sending_coin_id
    @user = user
  end

  def build
    @conversion = Conversion.new(
      receive_coin: receive_coin,
      sending_coin: sending_coin,
      user: @user
    )

    update_amounts
  end

  def update_amounts
    current_market_info = fetch_market_info

    @conversion.tap do |conversion|
      conversion.rate = current_market_info["rate"]
      conversion.max_amount = current_market_info["limit"]
      conversion.min_amount = current_market_info["minimum"]
    end
  end

  private

  def pair
    [sending_coin, receive_coin].map(&:symbol).map(&:downcase).join("_")
  end

  def receive_coin
    @receive_coin ||= Coin.find(@receive_coin_id)
  end

  def sending_coin
    @sending_coin ||= Coin.find(@sending_coin_id)
  end

  def fetch_market_info
    shapeshift_client.market_info(pair: pair)
  end

  def shapeshift_client
    Container[:shapeshift_client]
  end
end
