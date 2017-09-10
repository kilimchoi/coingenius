module BittrexOrdersHistoryImports
  class Process
    include Interactor

    MAPPED_HEADERS = [
      "Closed", "TimeStamp", "Exchange", "OrderType", "Bid/Ask", "Units Filled", "Quantity", "PricePerUnit", "Cost / Proceeds"
    ]

    delegate :bittrex_orders_history_import, :user, to: :context
    delegate :user, to: :bittrex_orders_history_import

    def call
      CSV.parse(bittrex_orders_history_import.file_content, headers: MAPPED_HEADERS).each_with_index do |order_row, index|
        # Skip initial headers row
        next if index.zero?

        # Add missing info to data hash
        order_row.tap do |order_data|
          order_data["Closed"] = Time.strptime(order_data["Closed"], "%m/%d/%Y %l:%M:%S %p").to_s
          order_data["OrderType"].sub!(" ", "_").upcase!
          order_data["QuantityRemaining"] = (BigDecimal.new(order_data["Quantity"], 12) - BigDecimal.new(order_data["Units Filled"], 12)).to_f
          order_data["TimeStamp"] = Time.strptime(order_data["TimeStamp"], "%m/%d/%Y %l:%M:%S %p").to_s
        end

        order = ::Bittrex::Order.new(order_row.to_h)

        bittrex_order = BittrexOrders::CreateFromOrder.call(order: order, user: user).bittrex_order
        bittrex_order&.update!(bittrex_orders_history_import_id: bittrex_orders_history_import.id)
      end

      bittrex_orders_history_import.update!(processed_at: Time.current)
    end
  end
end
