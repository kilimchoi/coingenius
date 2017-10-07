module EmailSubscriptions
  class WeeklyPortfolioItemWorker
    include Sidekiq::Worker

    def perform(user_id)
      user = User.find(user_id)
      transactions_group = user
                            .weekly_user_transactions_groups
                            .find_by(week_number: WeeklyUserTransactionsGroup.current_week_number)

      Users::WeeklyPortfolioReportMailer.send_email(user, transactions_group).deliver_now
    end
  end
end
