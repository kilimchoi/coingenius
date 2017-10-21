module EmailSubscriptions
  class WeeklyPortfolioItemWorker
    include Sidekiq::Worker

    delegate :current_week_number, to: "WeeklyUserTransactionsGroup"

    def perform(user_id)
      @user = User.find(user_id)
      @transactions_groups = @user.weekly_user_transactions_groups

      return if skip_user?

      Users::WeeklyPortfolioReportMailer.send_email(@user, current_transactions_group).deliver_now
    end

    private

    def skip_user?
      @transactions_groups.count <= 1 &&
        @transactions_groups.find_by(week_number: current_week_number - 1).nil?
    end

    def current_transactions_group
      @transactions_groups.find_by(week_number: current_week_number)
    end
  end
end
