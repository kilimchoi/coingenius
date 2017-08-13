module Bittrex
  class Order
    SELL_TYPE = "LIMIT_SELL".freeze
    BUY_TYPE = "LIMIT_BUY".freeze
    TYPES = [SELL_TYPE, BUY_TYPE].freeze

    attr_reader :type, :id, :limit,
                :exchange, :price, :quantity, :remaining,
                :total, :fill, :executed_at, :closed, :raw

    def initialize(attrs = {})
      @id = attrs["Id"] || attrs["OrderUuid"]
      @type = (attrs["Type"] || attrs["OrderType"])
      @exchange = attrs["Exchange"]
      @quantity = attrs["Quantity"]
      @remaining = attrs["QuantityRemaining"]
      @price = attrs["Rate"] || attrs["Price"]
      @total = attrs["Total"]
      @fill = attrs["FillType"]
      @limit = attrs["Limit"]
      @commission = attrs["Commission"]
      @closed = attrs["Closed"]
      @raw = attrs
      @executed_at = Time.parse(attrs["TimeStamp"])
    end

    def active?
      !closed?
    end

    def closed?
      @closed.present?
    end

    def sell?
      type == SELL_TYPE
    end

    def buy?
      type == BUY_TYPE
    end
  end
end
