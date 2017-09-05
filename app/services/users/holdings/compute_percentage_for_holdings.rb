module Users
  module Holdings
    class ComputePercentageForHoldings
      include Interactor
      delegate :holdings, :total to: :context

      def call
        holdings.each do |_key, holding|
          if total > 0
            holding[:percent] = holding[:total]/total
          end
        end
        holdings
      end
    end
  end
end
