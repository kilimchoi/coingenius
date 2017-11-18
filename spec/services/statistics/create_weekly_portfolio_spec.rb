require "rails_helper"

describe Statistics::CreateWeeklyPortfolio do
  describe "#call" do
    let(:service_call) { described_class.call(user: user, datetime: transaction_date) }
    let(:user) { create(:user) }
    let(:weekly_portfolio) { service_call.weekly_portfolio }
    let(:total) { instance_double("WeeklyUserTransactionsGroups::TotalPrice", value: 5000.0) }
    let(:transaction_date) { Time.zone.now.beginning_of_day }

    before do
      create(:transaction, :bought, user: user, transaction_date: transaction_date)
      WeeklyUserTransactionsGroup.refresh
    end

    it "creates weekly portfolio record" do
      expect(WeeklyUserTransactionsGroups::TotalPrice)
        .to receive(:new)
        .with(transactions_group: user.weekly_user_transactions_groups.last, datetime: transaction_date)
        .and_return(total)
      expect(service_call).to be_success
      expect(weekly_portfolio).to be_persisted
      expect(weekly_portfolio.total).to eq 5000.0
      expect(weekly_portfolio.week_number).to eq FormattedYearAndWeek.new(Time.zone.now).value
    end
  end
end
