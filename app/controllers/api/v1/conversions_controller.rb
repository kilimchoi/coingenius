module Api
  module V1
    class ConversionsController < Api::V1::ApplicationController
      respond_to :json

      expose :conversion, scope: -> {conversions}
      expose :conversions, -> {current_user.conversions}

      def index
        respond_with conversions
      end

      def new
        self.conversion = ConversionFactory.new(
          receive_coin_id: params[:receive_coin_id],
          sending_coin_id: params[:sending_coin_id],
          user: current_user
        ).build

        respond_with conversion
      end

      def show
        respond_with conversion
      end

      private

      def conversion_params
        params
          .require(:conversion)
          .permit(:sending_coin_id, :receive_coin_id, :source_wallet, :destination_wallet)
      end
    end
  end
end
