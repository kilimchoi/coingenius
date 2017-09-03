module DatesHelper
  def dates_before(days_back:, date_to: Date.today, include_first_day: false)
    days_back = include_first_day ? days_back : (days_back - 1)
    date_from = date_to - days_back

    dates_between(date_from, date_to)
  end

  def dates_between(date_from, date_to)
    (date_from..date_to).to_a
  end
end
