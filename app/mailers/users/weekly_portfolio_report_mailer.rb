module Users
  class WeeklyPortfolioReportMailer < MandrillMailer::TemplateMailer
    DEFAULT_TEMPLATE_NAME = "users-weekly-portfolio".freeze

    def send_email(user, portfolio)
      mandrill_mail(
        important: true,
        inline_css: true,
        subject: "Your Portfolio up #{portfolio.weekly_change_percentage} last week",
        template: DEFAULT_TEMPLATE_NAME,
        to: {
          email: user.email,
          name: user.username,
        },
        vars: {
          "TOTAL" => user.transactions.sum(:amount).to_f,
          "WEEK_RANGE" => "#{portfolio.week_starts_at} — #{portfolio.week_ends_at}",
          "WEEKLY_CHANGE_PERCENTAGE" => portfolio.weekly_change_percentage,
        },
       )
    end
  end
end
