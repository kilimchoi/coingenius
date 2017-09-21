module Users
  module Holdings
    class GetHoldings
      include Interactor
      
      delegate :user, to: :context

      before do 
        context.holdings = {}
        context.total = 0
      end

      def call
        merged_transactions.each do |transaction|
          coin = transaction.coin
          holding = holdings[coin.symbol]
          yearly_history, monthly_history, weekly_history = Users::Holdings::GetPriceHistoryForHolding.call(holding: holding)
          total_change, quantity_change = Users::Holdings::CalculateTotalAndQuantityChangeForHolding.call(holding: holding, 
                                                                                                transaction: transaction, 
                                                                                                weekly_history: weekly_history)
          total += total_change
          holdings = Users::Holdings::UpdateHolding.call(holding: holding, 
                                               yearly_history: yearly_history, 
                                               monthly_history: monthly_history,
                                               weekly_history: weekly_history, 
                                               total_change: total_change, 
                                               quantity_change: quantity_change,
                                               holdings: holdings)
        end
        holdings = Users::Holdings::ComputePercentageForHoldings.call(holdings: holdings, total: total)
        [holdings.values, total]
      end

      private

      def merged_transactions
        #we need to process buy transactions first and sell transactions next to cancel each other out. otherwise, order is random.
        user.transactions.bought.where(is_expired: false).includes(:coin) + user.transactions.sold.where(is_expired: false).includes(:coin)
      end
    end
  end
end
