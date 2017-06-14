class Portfolio::PortfolioController < ApplicationController
  
  def index
    @coins = Coin.all
    @transaction = Transaction.new
    if current_user
      @transactions = current_user.transactions.order(created_at: :desc)
      @holdings, @total = current_user.holdings if current_user
      @daily_history = [0] * 24
      @weekly_history = [0] * 7
      @monthly_history = [0] * 30
      @holdings.map do |h| 
        amount = h[:amount]
        h[:daily_price_history].each_with_index do |price, index|
          if !amount.nil?
            @daily_history[index] += (amount * price).to_s.to_f.round(2)
          end
        end
        h[:weekly_price_history].each_with_index do |price, index|
          if !amount.nil?
            @weekly_history[index] += (amount * price).to_s.to_f.round(2)
          end
        end
        h[:monthly_price_history].each_with_index do |price, index|
          if !amount.nil?
            @monthly_history[index] += (amount * price).to_s.to_f.round(2)
          end
        end
      
        
      end
      @last_seven_days = last_seven_days
      @last_thirty_days = last_thirty_days 
      @last_twenty_four_hours = last_twenty_four_hours
      @last_three_six_five_days = last_three_six_five_days
    end
  end

  private

  def last_seven_days
    (Date.today-6..Date.today).map {|d| d.strftime("%B %d")}
  end

  def last_twenty_four_hours
    ["6am", "7am", "8am", "9am", "10am", "11am", "12pm", "1pm", "2pm", "3pm", "4pm", "5pm", "6pm", "7pm", "8pm", "9pm", "10pm", "11pm",
      "12am", "1am", "2am", "3am", "4am", "5am"]
  end

  def last_three_six_five_days
    (Date.today-364..Date.today).map {|d| d.strftime("%B %d")}
  end

  def last_thirty_days 
    last_start = (Date.today-1.weeks).beginning_of_week.strftime("%B %d")
    last_end = (Date.today-1.weeks).end_of_week.strftime("%B %d")
    this_start = (Date.today).beginning_of_week.strftime("%B %d")
    this_end = (Date.today).strftime("%B %d")
    ["#{last_start}-#{last_end}", "#{this_start}-#{this_end}"]
  end
end

