module Users
  module Bittrex
    class ProcessOrdersHistory
      include Interactor

      MAPPED_HEADERS = [
        "Closed", "TimeStamp", "Exchange", "OrderType", "Bid/Ask", "Units Filled", "Quantity", "PricePerUnit", "Cost / Proceeds"
      ]

      delegate :csv_file_path, :user, to: :context

      def call
        CSV.foreach(csv_file_path, headers: MAPPED_HEADERS).each_with_index do |order_row, index|
          # Skip initial headers row
          next if index.zero?

          # Add missing info to data hash
          order_row.tap do |order_data|
            order_data["Closed"] = Time.strptime(order_data["Closed"], "%m/%d/%Y %l:%M:%S %p").to_s
            order_data["OrderType"].sub!(" ", "_").upcase!
            order_data["QuantityRemaining"] = (BigDecimal.new(order_data["Quantity"], 12) - BigDecimal.new(order_data["Units Filled"], 12)).to_f
            order_data["TimeStamp"] = Time.strptime(order_data["TimeStamp"], "%m/%d/%Y %l:%M:%S %p").to_s
          end

          # Check if we already created an order by checking via
          #   [transaction type, closed date, market]

          order = ::Bittrex::Order.new(order_row.to_h)
          BittrexOrders::CreateFromOrder.call(order: order, user: user)
        end
      end
    end
  end
end
