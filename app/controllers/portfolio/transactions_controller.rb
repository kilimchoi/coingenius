class Portfolio::TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def new
    @transaction = current_user.transactions.new
    @coins = Coin.all
  end

  def create
    if params["transaction"]["transaction_type"] == "sold"
      booleans = current_user.holdings[0].map {|h| h[:coin].id == params["transaction"]["coin_id"].to_i }
      if !booleans.include? true
        flash[:error] = "You do not have that coin"
        redirect_to '/portfolio'
      else
        @transaction = current_user.transactions.new(transaction_params)
        if @transaction.save
          flash[:success] = 'Your transaction has been created!'
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

end
