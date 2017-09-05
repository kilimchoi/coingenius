module Users
  module Holdings
    class CalculateTotalAndQuantityChangeForHolding
      include Interactor
      delegate :holding, :transaction, :weekly_history, to: :context

      def call
        if transaction.bought?
            quantity_change = transaction.amount
            total_change = (transaction.amount * weekly_history.last.to_f)
        else
          #check if holding exists and only decrement when transaction amount is smaller
          if holding && transaction.amount <= holding[:amount]
            quantity_change = -transaction.amount
            total_change = -(transaction.amount * weekly_history.last.to_f)
          else
            quantity_change = 0
            total_change = 0
          end
        end
        [total_change, quantity_change]
      end
    end
  end
end
