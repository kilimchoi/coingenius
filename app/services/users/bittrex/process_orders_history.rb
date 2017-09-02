module Users
  module Bittrex
    class ProcessOrdersHistory
      include Interactor

      delegate :csv_file, to: :context

      def call
        orders.each do |order|
          # 1. Check if we already created an order.
          # 2. Process order if not created yet
        end
      end

      private

      def orders

      end

    end
  end
end
