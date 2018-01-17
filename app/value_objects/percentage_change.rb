class PercentageChange < BaseValueObject
  attr_reader :previous, :current

  def initialize(previous:, current:)
    @previous = previous.to_f
    @current = current.to_f
  end

  def value
    @value ||= (100 * (current - previous) / previous.abs).round(2)
  end
end
