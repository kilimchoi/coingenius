require "rails_helper"

describe EmailSubscriptions::UnsubscribeUser do
  describe "#call" do
    let(:service_call) { described_class.call(email: user.email, tags: tags) }
    let(:user) { create(:user) }
    let(:tags) { %w[weekly_portfolio_report another_tag] }
    let!(:subscription) { create(:email_subscription, :weekly_portfolio_report, user: user, enabled: true) }

    it "disabled subscriptions by tag" do
      expect(service_call).to be_success
      expect(subscription.reload.enabled).to eq false
    end
  end
end
