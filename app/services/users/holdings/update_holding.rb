module Users
  module Holdings
    class UpdateHolding
      include Interactor
      delegate :holding, 
               :yearly_history, 
               :monthly_history, 
               :weekly_history, 
               :total_change, 
               :quantity_change, 
               :holdings to: :context

      def call
        if holding
          holding[:amount] += quantity_change
          holding[:total] += total_change
        else
          holdings[coin.symbol] = {
            coin: coin,
            percent_change: calculate_percentage_diff(weekly_history[-2].to_f, weekly_history[-1].to_f),
            amount: quantity_change,
            total: total_change,
            price: weekly_history.last,
            weekly_price_history: weekly_history,
            monthly_price_history: monthly_history,
            yearly_price_history: yearly_history,
          }
        end
        holdings
      end 

      private

      def calculate_percentage_diff(y1, y2)
        ((y2 - y1) / y1) * 100
      end
    end
  end
end
