class Portfolio::PortfolioController < ApplicationController
  
  def index
    @coins = Coin.all
    @transaction = Transaction.new
    if current_user
      @transactions = current_user.transactions.order(created_at: :desc)
      @holdings, @total = current_user.holdings if current_user
      
      @weekly_history = [0] * 7
      @monthly_history = [0] * 30
      @yearly_history = [0] * 365
      
      @last_twenty_four_hours = get_24_hours
      @last_seven_days = get_7_days
      @last_thirty_days = get_30_days
      @last_three_six_five_days = get_365_days

      @holdings.map do |h|
        amount = h[:amount]
        h[:weekly_price_history].each_with_index do |price, index|
          if !amount.nil?
            @weekly_history[index] += (price.to_f * amount.to_i).to_s.to_f.round(2)
          end
        end
        h[:monthly_price_history].each_with_index do |price, index|
          if !amount.nil?
            @monthly_history[index] += (price.to_f * amount.to_i).to_s.to_f.round(2)
          end
        end
        h[:yearly_price_history].each_with_index do |price, index|
          if !amount.nil?
            @yearly_history[index] += (price.to_f * amount.to_i).to_s.to_f.round(2)
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

  def get_7_days
    a = []
    7.downto(1) do |i|
      a << (Time.now - i.day).strftime("%Y-%m-%d")
    end
    a
  end

  def get_30_days
    a = []
    30.downto(1) do |i|
      a << (Time.now - i.day).strftime("%Y-%m-%d")
    end
    a
  end

  def get_365_days
    a = []
    365.downto(1) do |i|
      a << (Time.now - i.day).strftime("%Y-%m-%d")
    end
    a
  end
end

