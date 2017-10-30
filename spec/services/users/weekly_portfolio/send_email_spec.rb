require "rails_helper"

describe Users::WeeklyPortfolio::SendEmail do
  describe "#call" do
    let(:service_call) { described_class.call(weekly_portfolio: weekly_portfolio, user: user) }
    let(:user) { create(:user) }
    let(:previous_week) { 1.week.ago }
    let(:weekly_portfolio) { create(:statistics_weekly_portfolio, user: user, total: 1500.0) }
    let(:mailer) { instance_double("Users::WeeklyPortfolioReportMailer") }

    before do
      create(:statistics_weekly_portfolio,
        user: user,
        created_at: previous_week,
        total: 1200,
        week_number: FormattedYearAndWeek.new(previous_week).value)
    end

    it "calculates total price" do
      expect(Users::WeeklyPortfolioReportMailer)
        .to receive(:send_email)
        .with(user: user, total: weekly_portfolio.total, weekly_change_percentage: 25.0)
        .and_return(mailer)
      expect(mailer).to receive(:deliver_now)

      expect(service_call).to be_success
    end
  end
end
