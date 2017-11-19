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

      def create
        result = Conversions::Create.call(params: conversion_params, user: current_user)
        self.conversion = result.conversion

        respond_with conversion, api_v1_conversion_url(conversion.id)
      end

      private

      def conversion_params
        params
          .require(:conversion)
          .permit(:amount, :sending_coin_id, :receive_coin_id, :return_address, :withdrawal_address)
      end
    end
  end
end
