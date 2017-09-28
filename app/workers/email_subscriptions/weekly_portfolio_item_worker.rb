module EmailSubscriptions
  class WeeklyPortfolioItemWorker
    include Sidekiq::Worker

    def perform(user_id)
      user = User.find(user_id)
      transactions_group = user
                            .weekly_transactions_group
                            .find_by(week_number: WeeklyUserTransactionGroup.current_week_number)

      Users::WeeklyPortfolioReportMailer.new(user, transactions_group).deliver
    end
  end
end
