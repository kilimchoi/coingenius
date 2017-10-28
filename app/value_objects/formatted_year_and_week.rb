class FormattedYearAndWeek
  WEEK_FORMAT = "%V".freeze
  PREPEND_ZERO_FORMAT = "%02d".freeze

  def initialize(time = Time.zone.now)
    @year = time.year
    @week = time.strftime(WEEK_FORMAT).to_i
  end

  def value
    @value ||= "#{year}-#{formatted_week(week)}"
  end

  def next
    @next ||= "#{year}-#{formatted_week(week.next)}"
  end

  def previous
    @previous ||= "#{year}-#{formatted_week(week.pred)}"
  end

  private

  attr_reader :year, :week

  def formatted_week(week)
    format(PREPEND_ZERO_FORMAT, week)
  end
end
