module Users
  class WeeklyPortfolioReportMailer < MandrillMailer::TemplateMailer
    DEFAULT_VARS = {
      "LIST:COMPANY" => "CoinGenius",
    }

    delegate :email, :username, :transactions, to: :user
    delegate :weekly_change_percentage, :week_starts_at, :week_ends_at, to: :transactions_group

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
          "TOTAL" => transactions.sum(:amount).to_f,
          "WEEK_RANGE" => "#{week_starts_at} — #{week_ends_at}",
          "WEEKLY_CHANGE_PERCENTAGE" => weekly_change_percentage,
        }.merge(DEFAULT_VARS),
       )
    end

    private

    attr_reader :user, :transactions_group

    def subject_text
      return "Your portfolio hasn't changed" if weekly_change_percentage.zero?

      direction = weekly_change_percentage.positive? ? "up" : "down"

      "Your Portfolio #{direction} #{weekly_change_percentage}% last week"
    end
  end
end
