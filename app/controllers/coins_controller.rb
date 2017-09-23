class CoinsController < ApplicationController
  respond_to :html

  def index
    description = "Learn about pros and cons of top cryptocurrencies to help you make a better investment decision."
    keywords = %w[bitcoin ethereum ripple litecoin]
    set_meta_tags :description => description
    set_meta_tags keywords: keywords
    set_meta_tags :og => {
        :title    => :title,
        :description => description,
        :image => root_url[0..-2] + ActionController::Base.helpers.image_url('coingeniusx256.png')
    }

    response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/')
    @coins = []
    api_coins = JSON.parse(response.body)
    api_coins.each do |api_coin|
      api_coin = api_coin.with_indifferent_access
      coin = Coin.where(symbol: api_coin[:symbol]).first || Coin.create(symbol: api_coin[:symbol], name: api_coin[:name])
      next if !coin.pros
      coin.price = api_coin[:price_usd]
      coin.percent_change = api_coin[:percent_change_24h]
      coin.market_cap = api_coin[:market_cap_usd]
      @coins << coin
    end
    render
  end
end
