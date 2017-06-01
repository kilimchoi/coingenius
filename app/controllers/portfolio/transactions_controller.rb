class Portfolio::TransactionsController < ApplicationController

  def index

  end

  def create
    @transaction = current_user.transactions.new(transaction_params)
    status = @transaction.save
  
    respond_to do |format|
      format.html {
        if status
          flash[:success] = 'Your transaction has been created!'
        else
          flash[:error] = @transaction.errors.full_messages.join(', ')
        end
        redirect_to '/portfolio'
      }
      format.js
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
