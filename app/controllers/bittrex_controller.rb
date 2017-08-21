class BittrexController < ApplicationController
  def setup
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(bittrex_params)
      flash[:success] = 'You successfully integrated with bittrex. We will be pulling transactions from bittrex.'
    else
      flash[:error] = @user.errors.full_messages.join(', ')
    end
    redirect_to :back
  end

  private

  def bittrex_params
    params.require(:user).permit(:bittrex_api_key, :bittrex_api_secret)
  end
end
