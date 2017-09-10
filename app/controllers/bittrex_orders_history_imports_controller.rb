class BittrexOrdersHistoryImportsController < ApplicationController
  respond_to :html

  expose :bittrex_orders_history_import

  def new
  end

  def create
    bittrex_orders_history_import = current_user.bittrex_orders_history_imports.create!(
      file_content: bittrex_orders_history_import_params[:history_file].read
    )

    BittrexOrdersHistoryImports::ProcessWorker.perform_async(bittrex_orders_history_import.id)

    redirect_to portfolio_root_path
  end

  private

  def bittrex_orders_history_import_params
    params.require(:bittrex_orders_history_import).permit(:history_file)
  end
end
