require "uuid"

module BittrexOrdersHistoryImports
  class Process
    include Interactor

    HEADERS = %w[OrderUuid Exchange Type Quantity Limit Commission Price TimeStamp Closed].freeze

    delegate :bittrex_orders_history_import, :user, to: :context
    delegate :user, to: :bittrex_orders_history_import

    before do
      context.fail!(message: "Already processed") if bittrex_orders_history_import.processed_at.present?
    end

    def call
      CSV.parse(bittrex_orders_history_import.file_content, headers: HEADERS).each_with_index do |order_row, index|
        # Skip initial headers row
        next if index.zero? || order_row.length != HEADERS.length || !UUID.validate(order_row["OrderUuid"])

        # Reformat closed and opened timestamps
        order_row["Closed"] = Time.strptime(order_row["Closed"], "%m/%d/%Y %H:%M").to_s
        order_row["TimeStamp"] = Time.strptime(order_row["TimeStamp"], "%m/%d/%Y %H:%M").to_s

        # Calculate price per unit
        order_row["PricePerUnit"] = BigDecimal.new(order_row["Price"], 12) / BigDecimal.new(order_row["Quantity"], 12)

        order = ::Bittrex::Order.new(order_row.to_h)

        bittrex_order = BittrexOrders::CreateFromOrder.call(order: order, user: user).bittrex_order
        bittrex_order&.update!(bittrex_orders_history_import_id: bittrex_orders_history_import.id)
      end

      bittrex_orders_history_import.update!(processed_at: Time.current)
    end
  end
end
