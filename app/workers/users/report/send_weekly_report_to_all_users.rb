module Users
  module report
    class SendWeeklyReportToAllUsers
      include Sidekiq::Worker
      def perform
        User.find_each do |user|
          SendWeeklyReportToUser.perform_async(user.id)
        end
      end
    end
  end
end
