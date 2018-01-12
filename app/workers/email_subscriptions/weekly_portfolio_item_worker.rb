module EmailSubscriptions
  class WeeklyPortfolioItemWorker
    include Sidekiq::Worker
    
    sidekiq_options queue: 'email_subscriptions', retry: 5

    def perform(user_id)
      user = User.find(user_id)

      Users::WeeklyPortfolio::Create.call(user: user)
    end
  end
end
