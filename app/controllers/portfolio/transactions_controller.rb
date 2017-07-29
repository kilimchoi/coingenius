class Portfolio::TransactionsController < ApplicationController
  before_action :authenticate_user!
  autocomplete :coin, :name, full: true, :extra_data => [:symbol], display_value: :name_and_symbol

  def autocomplete_coin_name
    term = params[:term]
    if term.present?
      items = Coin.where("lower(coins.name) OR lower(coins.symbol) LIKE '%#{term}%'").order(:name)
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
    params["transaction"]["coin_id"].to_i
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
