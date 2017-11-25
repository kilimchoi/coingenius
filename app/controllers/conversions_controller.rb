class ConversionsController < ApplicationController
  respond_to :json

  expose :conversion, scope: -> { conversions }
  expose :conversions, -> { current_user.conversions }

  def index
    respond_with conversions
  end

  def new
    self.conversion = Conversions::Build.call(
      receive_coin_id: params[:receive_coin_id],
      sending_coin_id: params[:sending_coin_id],
      user: current_user
    ).conversion

    respond_with conversion
  end

  def show
    respond_with conversion
  end

  def create
    self.conversion = Conversions::Create.call(**create_params).conversion

    respond_with conversion, location: conversion_url(conversion.id)
  end

  private

  def create_params
    conversion_params
      .to_h
      .symbolize_keys
      .merge(user: current_user)
  end

  def conversion_params
    params
      .require(:conversion)
      .permit(:amount, :sending_coin_id, :receive_coin_id, :return_address, :withdrawal_address)
  end
end
