module CalculationUtility
  module_function

  def percentage_difference(y1, y2)
    abs_diff = (y1 - y2).abs
    half_sum = (y1 + y2) / 2

    (100 * abs_diff / half_sum).round(2)
  end
end
