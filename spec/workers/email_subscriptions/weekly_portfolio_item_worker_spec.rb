require "rails_helper"

describe EmailSubscriptions::WeeklyPortfolioItemWorker, type: :worker do
  include_context :worker_examples

  describe "#perform" do
    let(:user) { create(:user) }

    after { worker.perform(user.id) }

    it "triggers email delivery" do
      expect(Users::WeeklyPortfolio::Create).to receive(:call).with(user: user)
    end
  end
end
