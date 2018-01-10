class BinanceIntegrationsController < ApplicationController
  respond_to :html

  before_action :strip_whitespaces_in_params!, only: :create

  def new
  end

  def create
    accounts_with_same_api_key = User.where(binance_api_key: binance_params[:binance_api_key]).where.not(id: current_user.id)

    if accounts_with_same_api_key.any?
      flash[:error] = "You have already imported transactions from your Binance account using another CoinGenius account. Please use a different Binance account and create a new key."
    elsif current_user.update(binance_params)
      flash[:success] = "You successfully integrated with Binance. We will be pulling transactions from Binance."

      Users::Binance::SyncDataWorker.perform_async(current_user.id)
    else
      flash[:error] = current_user.errors.full_messages.join(", ")
    end

    redirect_back fallback_location: root_path
  end

  private

  def binance_params
    params.require(:user).permit(:binance_api_key, :binance_api_secret)
  end

  private

  def strip_whitespaces_in_params!
    binance_params.to_h.map { |_key, value| value&.strip! }
  end
end
