class CoinsController < ApplicationController
  respond_to :html

  expose :coins, -> { Coin.all }

  def index
    respond_with coins
  end
end
