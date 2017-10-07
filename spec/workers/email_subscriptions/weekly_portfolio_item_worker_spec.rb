require "rails_helper"

describe EmailSubscriptions::WeeklyPortfolioItemWorker, type: :worker do
  include_context :worker_examples

  let(:sidekiq_options) { {} }

  describe "#perform" do
    let(:user) { create(:user_with_transactions) }
    let(:mailer) { double(:mailer) }
    let(:transactions_group) do
      user.weekly_user_transactions_groups.find_by(week_number: WeeklyUserTransactionsGroup.current_week_number)
    end

    after { worker.perform(user.id) }

    it "triggers email delivery" do
      expect(Users::WeeklyPortfolioReportMailer).to receive(:send_email).with(user, transactions_group).and_return(mailer)
      expect(mailer).to receive(:deliver_now)
    end
  end
end
