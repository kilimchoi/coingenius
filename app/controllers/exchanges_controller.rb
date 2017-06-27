class ExchangesController < ApplicationController
  respond_to :html
  expose :exchanges, -> { Exchange.where.not(pros: nil) }
  def index
    respond_with exchanges 
  end
end
