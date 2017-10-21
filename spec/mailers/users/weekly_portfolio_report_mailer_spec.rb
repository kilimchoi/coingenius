require "rails_helper"

describe Users::WeeklyPortfolioReportMailer do
  let(:mailer) { described_class.new }

  describe "#send_email" do
    let(:transactions_group) { user.reload.weekly_user_transactions_groups.by_week_number.first }
    let(:mandrilla_options) do
      {
        important: true,
        inline_css: true,
        subject: subject,
        template: :users_weekly_portfolio_report,
        view_content_link: false,
        to: { email: user.email, name: user.username },
        vars: {
          "TOTAL" => total,
          "WEEK_RANGE" => "#{start} — #{finish}",
          "WEEKLY_CHANGE_PERCENTAGE" => change,
          "PORTFOLIO_LINK" => "http://example.com/portfolio"
        }
      }
    end

    after { mailer.send_email(user, transactions_group) }

    context "when transactions_group is present" do
      let(:user) { create(:user_with_transactions) }
      let(:start) { transactions_group.week_starts_at.strftime(described_class::TIME_FORMAT) }
      let(:finish) { transactions_group.week_ends_at.strftime(described_class::TIME_FORMAT) }
      let(:subject) { "Your Portfolio up 71.43% last week" }
      let(:total) { 19.0 }
      let(:change) { 71.43 }

      it { expect(mailer).to receive(:mandrill_mail).with(mandrilla_options) }
    end

    context "when transactions_group is nil" do
      let(:user) { create(:user) }
      let(:start) { Time.zone.now.beginning_of_week.strftime(described_class::TIME_FORMAT) }
      let(:finish) { Time.zone.now.end_of_week.strftime(described_class::TIME_FORMAT) }
      let(:subject) { "Your portfolio hasn't changed" }
      let(:total) { 12.0 }
      let(:change) { 0.0 }

      before do
        create(:transaction, :bought, user: user, amount: 1.2, price: 10.0)
      end

      it { expect(mailer).to receive(:mandrill_mail).with(mandrilla_options) }
    end
  end
end
