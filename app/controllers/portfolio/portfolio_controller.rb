class Portfolio::PortfolioController < ApplicationController

  def index
    @coins = Coin.all
    @transaction = Transaction.new
    @transactions = current_user.transactions
  end
end
