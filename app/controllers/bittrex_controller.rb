class BittrexController < ApplicationController
  def setup
    @user = current_user
  end

  def update
    @user = current_user
    accounts_with_same_api_key = User.where(bittrex_api_key: params["user"]["bittrex_api_key"])
    if !accounts_with_same_api_key.empty?
      flash[:error] = "You have already used that api key for another account. Please use a different api key or log in with another account using that key."
    elsif @user.update_attributes(bittrex_params)
      flash[:success] = 'You successfully integrated with bittrex. We will be pulling transactions from bittrex.'
      Users::Bittrex::SyncOrdersForUserWorker.perform_async(current_user.id)
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
