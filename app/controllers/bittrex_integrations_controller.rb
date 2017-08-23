class BittrexIntegrationsController < ApplicationController
  respond_to :html
  expose :user, -> { current_user }

  def new
  end

  def create
    accounts_with_same_api_key = User.where(bittrex_api_key: params["user"]["bittrex_api_key"])
    if !accounts_with_same_api_key.empty?
      flash[:error] = "You have already imported transactions from your Bittrex account. Please use a different Bittrex account and create a new key."
    elsif user.update_attributes(bittrex_params)
      flash[:success] = "You successfully integrated with bittrex. We will be pulling transactions from bittrex."
      Users::Bittrex::SyncOrdersForUserWorker.perform_async(user.id)
    else
      flash[:error] = user.errors.full_messages.join(', ')
    end
    redirect_to :back
  end

  private

  def bittrex_params
    params.require(:user).permit(:bittrex_api_key, :bittrex_api_secret)
  end
end
