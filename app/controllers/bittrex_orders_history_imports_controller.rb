class BittrexOrdersHistoryImportsController < ApplicationController
  respond_to :html

  expose :bittrex_orders_history_import

  def new
  end

  def create
    bittrex_orders_history_import = current_user.bittrex_orders_history_imports.create!(
      file_content: bittrex_orders_history_import_params[:history_file].read.gsub!(/\0/, "")
    )
    if bittrex_orders_history_import.file_content.nil?
      flash[:error] = "File is nil. Please click load all button on bittrex and try again."
      redirect_back fallback_location: root_path
    else
      BittrexOrdersHistoryImports::ProcessWorker.perform_async(bittrex_orders_history_import.id)

      redirect_to portfolio_root_path, notice: "Your Bittrex orders history file will be processed soon"
    end
  end

  private

  def bittrex_orders_history_import_params
    params.require(:bittrex_orders_history_import).permit(:history_file)
  end
end
