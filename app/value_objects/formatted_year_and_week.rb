class FormattedYearAndWeek
  WEEK_FORMAT = "%V".freeze

  def initialize(time = Time.zone.now)
    @year = time.year
    @week = time.strftime(WEEK_FORMAT).to_i
  end

  def value
    @value ||= "#{year}-#{week}"
  end

  def next
    "#{year}-#{week.next}"
  end

  def previous
    "#{year}-#{week.pred}"
  end

  private

  attr_reader :year, :week
end
