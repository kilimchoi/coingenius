class Portfolio::PortfolioController < ApplicationController

  def index
    @coins = Coin.all
    @transaction = Transaction.new
    @transactions = current_user.transactions.order(created_at: :desc)

    @holdings, @total = current_user.holdings

    @holdings = @holdings.sort_by{|holding| holding[:percentage]}
    @movers = @holdings.sort_by{|holding| holding[:percent_change].to_f}.reverse
  end
end
