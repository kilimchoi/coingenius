class WeeklyUserTransactionsGroup < ApplicationRecord
  self.primary_key = :id

  belongs_to :user

  scope :by_week_number, ->(direction = :desc) { order(week_number: direction) }

  class << self
    def refresh
      Scenic
        .database
        .refresh_materialized_view(
          table_name,
          concurrently: false,
          cascade: false
        )
    end

    def find_by_week(user_id, week_number = current_week_number)
      find_by(user_id: user_id, week_number: week_number)
    end

    def current_week_number
      Time.now.strftime("%U").to_i
    end
  end


  def weekly_change_percentage
    previous_record = self.class.find_by_week(user_id, week_number - 1)

    return 0 unless previous_record

    PercentageChange.new(previous: previous_record.price, current: price).value
  end
end
