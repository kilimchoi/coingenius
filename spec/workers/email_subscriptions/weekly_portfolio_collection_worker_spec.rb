require "rails_helper"

describe EmailSubscriptions::WeeklyPortfolioCollectionWorker, type: :worker do
  include_context :worker_context

  let(:sidekiq_options) { {} }

  describe "#perform" do
    let(:item_worker) { EmailSubscriptions::WeeklyPortfolioItemWorker }
    let!(:user1) { create(:user_with_transactions) }
    let!(:user2) { create(:user) }
    let!(:email_subscription1) { create(:email_subscription, :weekly_portfolio_report, :enabled, user: user1) }
    let!(:email_subscription2) { create(:email_subscription, :weekly_portfolio_report, user: user2) }

    after { worker.perform }

    it { expect(item_worker).to receive(:perform_async).with(user1.id) }
  end
end
