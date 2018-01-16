require "rails_helper"

describe Statistics::UpdateWeeklyPortfolio do
  describe "#call" do
    let(:service_call) { described_class.call(transaction: transaction) }
    let(:transaction_date) { 1.week.ago }
    let(:week_number) { FormattedYearAndWeek.new(transaction_date).value }
    let!(:transaction) do
      Transaction.skip_callback :commit, :after, :update_weekly_portfolio

      create(:transaction, :bought, user: user, transaction_date: transaction_date).tap do
        Transaction.set_callback :commit, :after, :update_weekly_portfolio
        WeeklyUserTransactionsGroup.refresh
      end
    end
    let!(:user) { create(:user) }
    let!(:weekly_portfolio) do
      create(:statistics_weekly_portfolio,
        user: user, total: 100.0, created_at: transaction_date, week_number: week_number)
    end
    let(:total) { instance_double("Portfolios::TotalMoneyPrice", value: 5000.0) }
    let(:transactions_group) { user.weekly_user_transactions_groups.last }

    it "creates weekly portfolio record" do
      expect(Portfolios::TotalMoneyPrice)
        .to receive(:new)
        .with(
          coin: transactions_group.coin,
          total_amount: transactions_group.total_amount,
          datetime: transaction_date
        )
        .and_return(total)

      expect(service_call).to be_success
      expect(weekly_portfolio.reload.total).to eq(5000.0)
    end
  end
end
