class CoinsController < ApplicationController
  respond_to :html

  expose :coins, -> { Coin.all }

  def index
    puts 'coins are ', coins.count
    respond_with coins
  end
end
