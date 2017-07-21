class Portfolio::TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def new
    @transaction = current_user.transactions.new
    @coins = Coin.order("symbol ASC")
  end

  def create
    if is_user_selling?
      if !user_has_coin?
        flash[:error] = "You do not have that coin"
        redirect_to '/portfolio'
      elsif !user_has_sufficient_amount? 
          flash[:error] = "You do not own enough coins"
          redirect_to '/portfolio'
      else
        @transaction = current_user.transactions.new(transaction_params)
        if @transaction.save
          flash[:success] = 'You successfully removed the coin'
        else
          flash[:error] = @transaction.errors.full_messages.join(', ')
        end
        redirect_to '/portfolio'
      end
    else
      @transaction = current_user.transactions.new(transaction_params)
      if @transaction.save
        flash[:success] = 'Your transaction has been created!'
      else
        flash[:error] = @transaction.errors.full_messages.join(', ')
      end
      redirect_to '/portfolio'
    end
  end

  def update

  end

  def destroy
  end

  private
  
  def transaction_params
    params.require(:transaction).permit(:price, :amount, :coin_id, :transaction_type)
  end

  def is_user_selling? 
    params["transaction"]["transaction_type"] == "sold"
  end

  def user_has_coin? 
    current_user.holdings.first.select do |h| 
      if h[:coin].id == params["transaction"]["coin_id"].to_i
        return true
      end
    end
    return false
  end

  def user_has_sufficient_amount? 
    coin_amount = 0
    current_user.holdings.first.select do |h| 
      if h[:coin].id == params["transaction"]["coin_id"].to_i
        coin_amount = h[:amount].to_s.to_f
        break
      end
    end
    coin_amount >= params["transaction"]["amount"].to_f
  end
end
