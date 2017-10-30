require "rails_helper"

describe Users::WeeklyPortfolioReportMailer do
  let(:mailer) { described_class.new }

  describe "#send_email" do
    let(:user) { build(:user) }
    let(:total) { 1000.0 }
    let(:start) { Time.zone.now.beginning_of_week.strftime(described_class::TIME_FORMAT) }
    let(:finish) { Time.zone.now.end_of_week.strftime(described_class::TIME_FORMAT) }
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
          "WEEKLY_CHANGE_PERCENTAGE" => weekly_change_percentage,
          "PORTFOLIO_LINK" => "http://example.com/portfolio"
        }
      }
    end

    after { mailer.send_email(user: user, total: total, weekly_change_percentage: weekly_change_percentage) }

    context "when weekly change is positive" do
      let(:weekly_change_percentage) { 70.0 }
      let(:subject) { "Your Portfolio up 70.0% last week" }

      it { expect(mailer).to receive(:mandrill_mail).with(mandrilla_options) }
    end

    context "when weekly change is negative" do
      let(:weekly_change_percentage) { -5.0 }
      let(:subject) { "Your Portfolio down -5.0% last week" }

      it { expect(mailer).to receive(:mandrill_mail).with(mandrilla_options) }
    end

    context "when portfolio has not changed" do
      let(:weekly_change_percentage) { 0.0 }
      let(:subject) { "Your portfolio hasn't changed" }

      it { expect(mailer).to receive(:mandrill_mail).with(mandrilla_options) }
    end
  end
end
