module Users
  class WeeklyPortfolioReportMailer < MandrillMailer::TemplateMailer
    SUBJECT_FORMAT = "Your Portfolio %s %.1f%% last week".freeze
    SUBJECT_PORTFOLIO_NOT_CHANGED = "Your portfolio hasn't changed".freeze
    TIME_FORMAT = "%b %d, %Y".freeze

    delegate :portfolio_root_url, to: "Rails.application.routes.url_helpers"
    delegate :full_host, to: "Rails.application.config"
    delegate :email, :username, to: :user

    def send_email(user:, total:, weekly_change_percentage:)
      @user = user
      @weekly_change_percentage = weekly_change_percentage

      mandrill_mail(
        important: true,
        inline_css: true,
        subject: subject_text,
        template: :users_weekly_portfolio_report,
        view_content_link: Rails.env.development?,
        to: { email: email, name: username },
        vars: {
          "TOTAL" => total,
          "WEEK_RANGE" => week_range,
          "WEEKLY_CHANGE_PERCENTAGE" => weekly_change_percentage,
          "PORTFOLIO_LINK" => portfolio_root_url(host: full_host)
        }
      )
    end

    private

    attr_reader :user, :weekly_change_percentage

    def subject_text
      NumberSign.call(weekly_change_percentage) do |match|
        match.positive { |value| format(SUBJECT_FORMAT, :up, value) }
        match.negative { |value| format(SUBJECT_FORMAT, :down, value) }
        match.zero { |_| SUBJECT_PORTFOLIO_NOT_CHANGED }
      end
    end

    def week_range
      now = Time.zone.now
      week_starts_at = now.beginning_of_week.strftime(TIME_FORMAT)
      week_ends_at = now.end_of_week.strftime(TIME_FORMAT)

      "#{week_starts_at} — #{week_ends_at}"
    end
  end
end
