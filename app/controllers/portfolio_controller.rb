class PortfolioController < ApplicationController

  def index
    @coins = Coin.all
  end
end
