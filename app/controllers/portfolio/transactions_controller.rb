class Portfolio::TransactionsController < ApplicationController
  before_action :authenticate_user!
  respond_to :html
  expose :transactions, -> { current_user.transactions.where(coin_id: params[:id], user_id: current_user.id)}
  expose :coin, -> { transactions.last.coin }

  def autocomplete_coin_name
    term = params[:term].downcase
    if term.present?
      items = Coin.where("lower(coins.symbol) LIKE '%#{term}' OR lower(coins.name) LIKE '%#{term}%'")
    else
      items = {}
    end
    extra_data = [:symbol]
    display_value = :name_and_symbol
    render json: json_for_autocomplete(items, display_value, extra_data)
  end

  def index

  end

  def new
    @transaction = current_user.transactions.new
    @coins = Coin.order("name ASC")
  end

  def create
    if is_user_selling?
      if !user_has_coin?
        flash[:error] = "You do not have that coin"
        redirect_to :back
      elsif !user_has_sufficient_amount? 
        flash[:error] = "You do not own enough coins"
        redirect_to :back
      else
        @transaction = current_user.transactions.new(transaction_params)
        if @transaction.save
          flash[:success] = 'You successfully removed the coin'
          redirect_to '/portfolio'
        else
          flash[:error] = @transaction.errors.full_messages.join(', ')
          redirect_to :back
        end
      end
    else
      @transaction = current_user.transactions.new(transaction_params)
      if @transaction.save
        flash[:success] = 'Your transaction has been created!'
        redirect_to '/portfolio'
      else
        flash[:error] = @transaction.errors.full_messages.join(', ')
        redirect_to :back
      end
    end
  end

  def edit
    @transaction = Transaction.find params[:id]
  end

  def update
    @transaction = Transaction.find params[:id]
    if @transaction.update_attributes(transaction_params)
      flash[:success] = 'You successfully updated the transaction'
      redirect_to :back
    else
      flash[:error] = @transaction.errors.full_messages.join(', ')
      redirect_to :back
    end
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
      if h[:coin].id == params["transaction"]["coin_id"].to_i &&
         h[:amount].to_s != "0.0"
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
