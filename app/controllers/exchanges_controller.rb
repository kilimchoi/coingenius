class ExchangesController < ApplicationController
  respond_to :html
  expose :exchanges, -> { Exchange.where.not(pros: nil).order(rank: :asc) }
  def index
    description = "Compare some of the well known cryptocurrency exchanges including their rates, deposit and withdrawl limits, and more."
    keywords = %w[gemini coinbase shapeshift bittrex]
    set_meta_tags :description => description
    set_meta_tags keywords: keywords
    set_meta_tags :og => {
        :title    => :title,
        :description => description,
        :image => root_url[0..-2] + ActionController::Base.helpers.image_url('coingeniusx256.png')
    }
    respond_with exchanges 
  end
end
