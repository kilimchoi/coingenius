require "rails_helper"

describe Statistics::CreateWeeklyPortfolio do
  describe "#call" do
    let(:service_call) { described_class.call(user: user) }
    let(:timestamp) { Time.zone.now.beginning_of_day.to_i }
    let(:user) { create(:user) }
    let(:total_price_context) { double(total_price: 5000.0) }

    before do
      create(:transaction, :bought, user: user)
    end

    it "creates weekly portfolio record" do
      expect(WeeklyUserTransactionsGroups::CalculateTotalPrice)
        .to receive(:call)
        .with(transactions_group: user.weekly_user_transactions_groups.last)
        .and_return(total_price_context)
      expect(service_call).to be_success
      expect(service_call.weekly_portfolio).to be_persisted
    end
  end
end
