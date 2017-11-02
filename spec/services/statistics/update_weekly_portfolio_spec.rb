require "rails_helper"

describe Statistics::UpdateWeeklyPortfolio do
  describe "#call" do
    let(:service_call) { described_class.call(transaction: transaction) }
    let(:transaction_date) { 1.week.ago }
    let(:week_number) { FormattedYearAndWeek.new(transaction_date).value }
    let!(:transaction) do
      Transaction.skip_callback :commit, :after,:update_weekly_portfolio
      record = create(:transaction, :bought, user: user, transaction_date: transaction_date)
      Transaction.set_callback :commit, :after, :update_weekly_portfolio

      record
    end
    let!(:user) { create(:user) }
    let!(:weekly_portfolio) do
      create(:statistics_weekly_portfolio,
        user: user, total: 100.0, created_at: transaction_date, week_number: week_number)
    end
    let(:total_price_context) { double(total_price: 5000.0) }

    it "creates weekly portfolio record" do
      expect(WeeklyUserTransactionsGroups::CalculateTotalPrice)
        .to receive(:call)
        .with(transactions_group: user.reload.weekly_user_transactions_groups.last)
        .and_return(total_price_context)

      expect(service_call).to be_success
      expect(weekly_portfolio.reload.total).to eq(total_price_context.total_price)
    end
  end
end
