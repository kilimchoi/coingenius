class NumberSign
  POSITIVE, NEGATIVE, ZERO = %i[positive negative zero].map do |sign|
    Dry::Matcher::Case.new(
      match: ->(value) { value.send("#{sign}?") },
      resolve: ->(value) { value }
    ).freeze
  end
  MATCHER = Dry::Matcher.new(
    positive: POSITIVE,
    negative: NEGATIVE,
    zero: ZERO
  ).freeze

  def self.call(number)
    MATCHER.call(number) { |match| yield match }
  end
end
