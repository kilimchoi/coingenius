module Users
  module Holdings
    class GetPriceHistoryForHolding
      include Interactor
      delegate :holding, to: :context

      def call 
        if holding
          yearly_history = holding[:yearly_price_history]
          monthly_history = holding[:monthly_price_history]
          weekly_history = holding[:weekly_price_history]
        else
          yearly_history = Coins::GetCachedPriceHistory.call(coin: coin, days: 365, price_currency: "USD").results
          monthly_history = yearly_data.last(30)
          weekly_history = yearly_data.last(7)
        end
        [yearly_history, monthly_history, weekly_history]
      end
    end
  end
end
