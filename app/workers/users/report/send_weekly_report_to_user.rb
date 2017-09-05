module Users
  module report
    class SendWeeklyReportToUser
      include Sidekiq::Worker
      def perform(user_id)
        WeeklyReportMailer.weekly_report(user_id).deliver
      end
    end
  end
end
