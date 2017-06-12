class Portfolio::PortfolioController < ApplicationController

  def index
    @coins = Coin.all
    @transaction = Transaction.new
    if current_user
      @transactions = current_user.transactions.order(created_at: :desc)
      @holdings, @total = current_user.holdings if current_user
      @history = [0] * 8
      @holdings.map do |h| 
        amount = h[:amount]
        h[:price_history].each_with_index do |price, index|
          if !amount.nil?
            @history[index] += (amount * price).to_s.to_f.round(2)
          end
        end
      end
    end
  end
end
