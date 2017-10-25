module EmailSubscriptions
  class WeeklyPortfolioItemWorker
    include Sidekiq::Worker

    def perform(user_id)
      user = User.find(user_id)

      Users::WeeklyPortfolio::Create.call(user: user)
    end
  end
end
