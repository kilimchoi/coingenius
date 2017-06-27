class ExchangesController < ApplicationController
  respond_to :html
  expose :exchanges, -> { Exchange.where.not(pros: nil).order(rank: :asc) }
  def index
    respond_with exchanges 
  end
end
