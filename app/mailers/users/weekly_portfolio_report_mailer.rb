module Users
  class WeeklyPortfolioReportMailer < MandrillMailer::TemplateMailer
    TIME_FORMAT = "%b %d, %Y".freeze

    delegate :portfolio_root_url, to: "Rails.application.routes.url_helpers"
    delegate :full_host, to: "Rails.application.config"
    delegate :email, :username, :transactions, to: :user
    delegate :weekly_change_percentage, :week_starts_at, to: :transactions_group

    def send_email(user, transactions_group)
      @user = user
      @transactions_group = transactions_group

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
          "PORTFOLIO_LINK" => portfolio_root_url(host: full_host),
        }
       )
    end

    private

    attr_reader :user, :transactions_group

    def subject_text
      return "Your portfolio hasn't changed" if weekly_change_percentage.zero?

      direction = weekly_change_percentage.positive? ? "up" : "down"

      "Your Portfolio #{direction} #{weekly_change_percentage}% last week"
    end

    def total
      transactions
        .sum { |tr| tr.amount * tr.price }
        .to_f
    end

    def week_range
      starts = (week_starts_at - 1.week).strftime(TIME_FORMAT)
      ends = week_starts_at.strftime(TIME_FORMAT)

      "#{starts} — #{ends}"
    end
  end
end
