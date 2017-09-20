class BittrexIntegrationsController < ApplicationController
  respond_to :html
  expose :user, -> { current_user }

  def new
  end

  def create
    accounts_with_same_api_key = User.where(bittrex_api_key: params["user"]["bittrex_api_key"])
    strip_whitespace(*params[:user])
    if !accounts_with_same_api_key.empty?
      flash[:error] = "You have already imported transactions from your Bittrex account using another CoinGenius account. Please use a different Bittrex account and create a new key."
    elsif user.update_attributes(bittrex_params)
      flash[:success] = "You successfully integrated with bittrex. We will be pulling transactions from bittrex."
      Users::Bittrex::SyncOrdersForUserWorker.perform_async(user.id)
    else
      flash[:error] = user.errors.full_messages.join(', ')
    end
    redirect_back fallback_location: root_path
  end

  private

  def bittrex_params
    params.require(:user).permit(:bittrex_api_key, :bittrex_api_secret)
  end

  private

  def strip_whitespace(*params)
    params.map{ |attr| attr.last.strip! }
  end
end
