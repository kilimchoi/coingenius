module Users
  module WeeklyPortfolio
    class SendEmail
      include Interactor

      delegate :previous_portfolio, :weekly_portfolio, :user, to: :context
      delegate :week_number, :total, to: :weekly_portfolio
      delegate :total, to: :previous_portfolio, prefix: :previous

      before do
        ActionMailer::Base.smtp_settings = {
          address:   "smtp.mandrillapp.com",
          port:      587,
          user_name: ENV["MANDRILL_USERNAME"],
          password:  ENV["MANDRILL_API_KEY"],
          domain:    Rails.application.config.full_host
        }

        ActionMailer::Base.delivery_method = :smtp
    
        context.previous_portfolio = Statistics::WeeklyPortfolio.find_by(
          user: user,
          week_number: FormattedYearAndWeek.new(weekly_portfolio.created_at).previous
        )
      end

      def call
        return unless previous_portfolio

        send_email
      end

      private

      def send_email
        Users::WeeklyPortfolioReportMailer
          .send_email(user: user, total: total, weekly_change_percentage: weekly_change_percentage)
          .deliver_now
      end

      def weekly_change_percentage
        return 100.0 if previous_total.zero?

        PercentageChange.new(previous: previous_total, current: total).value
      end
    end
  end
end
