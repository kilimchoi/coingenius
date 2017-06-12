class CoinsController < ApplicationController
  respond_to :html

  def index
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
