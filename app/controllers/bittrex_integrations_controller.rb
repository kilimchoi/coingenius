class BittrexIntegrationsController < ApplicationController
  respond_to :html
  expose :user, -> { current_user }

  def new
    respond_with user
  end

  def create
    if user.update_attributes(bittrex_params)
      flash[:success] = 'You successfully integrated with bittrex. We will be pulling transactions from bittrex.'
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
