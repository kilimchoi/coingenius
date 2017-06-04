class Portfolio::PortfolioController < ApplicationController

  def index
    @coins = Coin.all
    @transaction = Transaction.new
    @transactions = current_user.transactions.order(created_at: :desc)

    @holdings = current_user.holdings.sort_by{|holding| holding[:percentage]}
    @movers = current_user.holdings.sort_by{|holding| holding[:percent_change].to_f}
  end
end
