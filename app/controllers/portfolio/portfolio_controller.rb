class Portfolio::PortfolioController < ApplicationController
  
  def index
    @coins = Coin.all
    @transaction = Transaction.new
    if current_user
      @transactions = current_user.transactions.order(created_at: :desc)
      @holdings, @total = current_user.holdings if current_user
      
      daily_min = 300
      weekly_min = 700
      monthly_min = 800
      yearly_min = 400

      @holdings.map do |h|
        daily_min = h[:daily_price_history].length < daily_min ? h[:daily_price_history].length : daily_min 
        weekly_min = h[:weekly_price_history].length < weekly_min ? h[:weekly_price_history].length : weekly_min
        monthly_min = h[:monthly_price_history].length < monthly_min ? h[:monthly_price_history].length : monthly_min  
        yearly_min = h[:yearly_price_history].length < yearly_min ? h[:yearly_price_history].length : yearly_min
      end

      @daily_history = [0] * daily_min
      @weekly_history = [0] * weekly_min
      @monthly_history = [0] * monthly_min
      @yearly_history = [0] * yearly_min
      @last_twenty_four_hours = [0] * daily_min
      @last_seven_days = [0] * weekly_min
      @last_thirty_days = [0] * monthly_min
      @last_three_six_five_days = [0] * yearly_min

      @holdings.map do |h|
        amount = h[:amount]
        
        h[:daily_price_history].each_with_index do |pair, index|
          if !amount.nil?
            time_to_add = pair[0]
            if index < daily_min
              @last_twenty_four_hours[index] = time_to_add
              @daily_history[index] += (amount * pair[1]).to_s.to_f.round(2)
            else
              break
            end
          end
        end
        h[:weekly_price_history].each_with_index do |pair, index|
          if !amount.nil?
            time_to_add = pair[0]
            if index < weekly_min
              @last_seven_days[index] = time_to_add
              @weekly_history[index] += (amount * pair[1]).to_s.to_f.round(2)
            else
              break
            end
          end
        end
        h[:monthly_price_history].each_with_index do |pair, index|
          if !amount.nil?
            time_to_add = pair[0]
            if index < monthly_min
              @last_thirty_days[index] = time_to_add
              @monthly_history[index] += (amount * pair[1]).to_s.to_f.round(2)
            else
              break
            end
          end
        end
        h[:yearly_price_history].each_with_index do |pair, index|
          if !amount.nil?
            time_to_add = pair[0]
            if index < yearly_min
              @last_three_six_five_days[index] = time_to_add
              @yearly_history[index] += (amount * pair[1]).to_s.to_f.round(2)
            else
              break
            end
          end
        end
      end
    end
  end
end

