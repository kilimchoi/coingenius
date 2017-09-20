class BittrexIntegrationsController < ApplicationController
  respond_to :html

  before_action :strip_whitespaces_in_params!, only: :create

  def new
  end

  def create
    accounts_with_same_api_key = User.where(bittrex_api_key: bittrex_params[:bittrex_api_key]).where.not(id: current_user.id)

    if accounts_with_same_api_key.any?
      flash[:error] = "You have already imported transactions from your Bittrex account using another CoinGenius account. Please use a different Bittrex account and create a new key."
    elsif current_user.update(bittrex_params)
      flash[:success] = "You successfully integrated with bittrex. We will be pulling transactions from bittrex."

      Users::Bittrex::SyncOrdersForUserWorker.perform_async(current_user.id)
    else
      flash[:error] = current_user.errors.full_messages.join(', ')
    end

    redirect_back fallback_location: root_path
  end

  private

  def bittrex_params
    params.require(:user).permit(:bittrex_api_key, :bittrex_api_secret)
  end

  private

  def strip_whitespaces_in_params!
    bittrex_params.to_h.map {|_key, value| value&.strip!}
  end
end
