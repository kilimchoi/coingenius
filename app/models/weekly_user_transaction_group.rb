class WeeklyUserTransactionGroup < ApplicationRecord
  belongs_to :user

  def self.refresh
    Scenic
      .database
      .refresh_materialized_view(
        table_name,
        concurrently: false,
        cascade: false
      )
  end

  def self.previous_week_record(user_id, week_number = Time.now.strftime("%U").to_i - 1)
    find_by(user_id: user_id, week_number: week_number)
  end

  def weekly_change_percentage
    previous_record = self.class.previous_week_record(user_id, week_number)

    return 0 unless previous_record

    CalculationUtility.percentage_difference(amount.to_f, previous_record.amount.to_f)
  end
end
