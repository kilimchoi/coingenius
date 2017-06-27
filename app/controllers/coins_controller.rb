class CoinsController < ApplicationController
  respond_to :html

  def index
    description = "Learn about pros and cons of some of the top cryptocurrencies to help you make a better investment decision."
    keywords = %w[bitcoin ethereum ripple litecoin]
    set_meta_tags :description => description
    set_meta_tags keywords: keywords
    set_meta_tags :og => {
        :title    => :title,
        :description => description,
        :image => root_url[0..-2] + ActionController::Base.helpers.image_url('coingenius.png')
    }

    response = HTTParty.get('http://www.coincap.io/front')
    @coins = []
    api_coins = JSON.parse(response.body).sort_by{ |hash| hash['mktcap'].to_f }.reverse.first(100)
    api_coins.each do |api_coin|
      api_coin = api_coin.with_indifferent_access
      coin = Coin.where(symbol: api_coin[:short]).first || Coin.create(symbol: api_coin[:short], name: api_coin[:long])
      next if !coin.pros
      coin.price = api_coin[:price]
      coin.percent_change = api_coin[:perc]
      coin.market_cap = api_coin[:mktcap]
      @coins << coin
    end
    render
  end
end
