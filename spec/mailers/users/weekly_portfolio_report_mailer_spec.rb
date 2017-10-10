require "rails_helper"

describe Users::WeeklyPortfolioReportMailer do
  let(:mailer) { described_class.new }

  describe "#send_email" do
    let(:user) { create(:user_with_transactions) }
    let(:transactions_group) { user.reload.weekly_user_transactions_groups.by_week_number.first }
    let(:start) { transactions_group.week_starts_at.strftime(described_class::TIME_FORMAT) }
    let(:finish) { transactions_group.week_ends_at.strftime(described_class::TIME_FORMAT) }
    let(:mandrilla_options) do
      {
        important: true,
        inline_css: true,
        subject: "Your Portfolio up 71.43% last week",
        template: :users_weekly_portfolio_report,
        view_content_link: false,
        to: { email: user.email, name: user.username },
        vars: {
          "TOTAL" => 19.0,
          "WEEK_RANGE" => "#{start} — #{finish}",
          "WEEKLY_CHANGE_PERCENTAGE" => 71.43,
          "PORTFOLIO_LINK" => "http://example.com/portfolio"
        }
      }
    end

    after { mailer.send_email(user, transactions_group) }

    it { expect(mailer).to receive(:mandrill_mail).with(mandrilla_options) }
  end
end
