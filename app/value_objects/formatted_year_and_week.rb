class FormattedYearAndWeek
  FORMAT = "%G-%V".freeze

  def initialize(time = Time.zone.now)
    @time = time
  end

  def value
    @value ||= time.strftime(FORMAT)
  end

  def next
    @next ||= (time + 1.week).strftime(FORMAT)
  end

  def previous
    @previous ||= (time - 1.week).strftime(FORMAT)
  end

  private

  attr_reader :time
end
