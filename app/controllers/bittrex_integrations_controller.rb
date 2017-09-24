class BittrexIntegrationsController < ApplicationController
  respond_to :html

  before_action :strip_whitespaces_in_params!, only: :create
  expose :bittrex_orders_history_import

  def new
  end

  def create
    if !params["bittrex_orders_history_import_params"].nil?
      bittrex_orders_history_import = current_user.bittrex_orders_history_imports.create!(
        file_content: bittrex_orders_history_import_params[:history_file].read
      )
      BittrexOrdersHistoryImports::ProcessWorker.perform_async(bittrex_orders_history_import.id)

      redirect_to portfolio_root_path, notice: "Your Bittrex orders history file will be processed soon"
    end

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

  def bittrex_orders_history_import_params
    params.require(:bittrex_orders_history_import).permit(:history_file)
  end

  private

  def strip_whitespaces_in_params!
    bittrex_params.to_h.map {|_key, value| value&.strip!}
  end
end
