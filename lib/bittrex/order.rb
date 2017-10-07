module Bittrex
  class Order
    SELL_TYPE = "LIMIT_SELL".freeze
    BUY_TYPE = "LIMIT_BUY".freeze
    TYPES = [SELL_TYPE, BUY_TYPE].freeze

    attr_reader :type, :id, :limit,
      :exchange, :price, :price_per_unit, :quantity, :remaining,
      :total, :fill, :executed_at, :closed_at, :raw

    def initialize(attrs = {})
      @id = attrs["Id"] || attrs["OrderUuid"]
      @type = (attrs["Type"] || attrs["OrderType"])
      @exchange = attrs["Exchange"]
      @quantity = attrs["Quantity"]
      @remaining = attrs["QuantityRemaining"]
      @price = attrs["Rate"] || attrs["Price"]
      @price_per_unit = BigDecimal.new(attrs["PricePerUnit"], 12)
      @total = attrs["Total"]
      @fill = attrs["FillType"]
      @limit = attrs["Limit"]
      @commission = attrs["Commission"]
      @closed_at = Time.parse(attrs["Closed"])
      @raw = attrs
      @executed_at = Time.parse(attrs["TimeStamp"])
    end

    def active?
      !closed?
    end

    def closed?
      @closed_at.present?
    end

    def sell?
      type == SELL_TYPE
    end

    def buy?
      type == BUY_TYPE
    end
  end
end
