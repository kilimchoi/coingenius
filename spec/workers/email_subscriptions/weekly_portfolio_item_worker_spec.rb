require "rails_helper"

describe EmailSubscriptions::WeeklyPortfolioItemWorker, type: :worker do
  include_context :worker_examples

  let(:sidekiq_options) { {} }

  describe "#perform" do
    context "when user has transactions groups" do
      let(:user) { create(:user_with_transactions) }
      let(:mailer) { instance_double("Users::WeeklyPortfolioReportMailer") }
      let(:transactions_group) do
        user.weekly_user_transactions_groups.find_by(week_number: WeeklyUserTransactionsGroup.current_week_number)
      end

      after { worker.perform(user.id) }

      it "triggers email delivery" do
        expect(Users::WeeklyPortfolioReportMailer).to receive(:send_email).with(user, transactions_group).and_return(mailer)
        expect(mailer).to receive(:deliver_now)
      end
    end

    context "when user has only one transactions group" do
      let(:user) { create(:user) }

      before do
        create(:transaction, :bought,
          user: user, amount: 2, price: 10.0,
          transaction_date: Time.zone.now.beginning_of_week)
      end

      it "skips user" do
        expect(worker.perform(user.id)).to be_nil
      end
    end
  end
end
