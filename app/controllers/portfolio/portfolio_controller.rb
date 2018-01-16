class Portfolio::PortfolioController < ApplicationController
  include DatesHelper
  layout :current_layout # on top of the controller

  before_action :prepare_portfolio_changes, only: %i[index]

  def current_layout
    current_user ? "application" : "landing_page_application"
  end

  def update_default_currency
    current_user.user_currency = params[:currency]
    current_user.save!
    respond_to do |format|
      format.json { head :ok }
    end
  end

  def index
    description = "Create your cryptocurrency portfolio to track your investment returns."
    set_meta_tags description: description
    set_meta_tags og: {
      title: :title,
      description: description,
      image: root_url[0..-2] + ActionController::Base.helpers.image_url("coingeniusx256.png")
    }

    @coins = Coin.all
    @transaction = Transaction.new

    if current_user
      @transactions = current_user.transactions.order(created_at: :desc)
      @holdings, @total = current_user.holdings if current_user

      @weekly_history = [0] * 7
      @monthly_history = [0] * 30
      @yearly_history = [0] * 365

      days_ago = dates_before(days_back: 365).map { |date| date.strftime("%Y-%m-%d") }

      @last_twenty_four_hours = get_24_hours
      @last_seven_days = days_ago.last(7)
      @last_thirty_days = days_ago.last(30)
      @last_three_six_five_days = days_ago

      @holdings = @holdings.sort_by { |h| h[:total] }.reverse
      @holdings.map do |h|
        amount = h[:amount]
        h[:weekly_price_history].each_with_index do |price, index|
          unless amount.nil?
            @weekly_history[index] += (price.to_f * amount.to_f).round(2)
          end
        end
        h[:monthly_price_history].each_with_index do |price, index|
          unless amount.nil?
            @monthly_history[index] += (price.to_f * amount.to_f).round(2)
          end
        end
        h[:yearly_price_history].each_with_index do |price, index|
          unless amount.nil?
            @yearly_history[index] += (price.to_f * amount.to_f).round(2)
          end
        end
      end
    end
  end

  private

  def get_24_hours
    a = []
    1.upto(24) do |i|
      a << (Time.now - i.hour).strftime("%Y-%m-%d %H:%M%p")
    end
    a
  end

  def prepare_portfolio_changes
    @weekly_changes, @monthly_changes, @yearly_changes = Statistics::CollectPortfolioTotalChanges.call(
      user: current_user
    ).results.map { |change| "#{change.difference} (#{change.percentage_difference}%)" }
  end
end
