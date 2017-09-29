
class WeeklyUserTransactionsGroup < ApplicationRecord
  belongs_to :user

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

    def previous_week_record(user_id, week_number = current_week_number - 1)
      find_by(user_id: user_id, week_number: week_number)
    end

    def current_week_number
      Time.now.strftime("%U").to_i
    end
  end

  def weekly_change_percentage
    previous_record = self.class.previous_week_record(user_id, week_number)

    return 0 unless previous_record

    PercentageDifference.new(amount, previous_record.amount).value
  end
end
