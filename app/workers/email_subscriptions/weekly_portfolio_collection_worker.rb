module EmailSubscriptions
  class WeeklyPortfolioCollectionWorker
    include Sidekiq::Worker

    sidekiq_options queue: "email_subscriptions", retry: 5

    def perform
      WeeklyUserTransactionsGroup.refresh

      collection.each { |item| EmailSubscriptions::WeeklyPortfolioItemWorker.perform_async(item) }
    end

    private

    def collection
      User
        .distinct
        .joins(:transactions, :email_subscriptions)
        .merge(EmailSubscription.enabled.weekly_portfolio_report)
        .pluck(:id)
    end
  end
end
