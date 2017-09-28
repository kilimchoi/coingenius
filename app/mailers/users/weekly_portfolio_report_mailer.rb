module Users
  class WeeklyPortfolioReportMailer < MandrillMailer::TemplateMailer
    def send_email(user, transactions_group)
      mandrill_mail(
        important: true,
        inline_css: true,
        subject: subject_text(transactions_group.weekly_change_percentage),
        template: :users_weekly_portfolio_report,
        view_content_link: Rails.env.development?,
        to: {
          email: user.email,
          name: user.username,
        },
        vars: {
          "TOTAL" => user.transactions.sum(:amount).to_f,
          "WEEK_RANGE" => "#{transactions_group.week_starts_at} — #{transactions_group.week_ends_at}",
          "WEEKLY_CHANGE_PERCENTAGE" => transactions_group.weekly_change_percentage,
        },
       )
    end

    private

    def subject_text(weekly_change_percentage)
      return "Your portfolio hasn't changed" if weekly_change_percentage.zero?

      direction = weekly_change_percentage.positive? ? "up" : "down"

      "Your Portfolio #{direction} #{weekly_change_percentage}% last week"
    end
  end
end
