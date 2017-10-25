module Users
  module WeeklyPortfolio
    class SendEmail
      include Interactor

      delegate :weekly_portfolio, :user, to: :context
      delegate :week_number, :total, to: :weekly_portfolio

      def call
        return unless previous_portfolio

        send_email
      end

      private

      def previous_portfolio
        Statistics::WeeklyPortfolio.find_by(user: user, week_number: previous_week_number)
      end

      def previous_week_number
        FormattedYearAndWeek.new(weekly_portfolio.created_at).previous
      end

      def send_email
        Users::WeeklyPortfolioReportMailer
          .send_email(user: user, total: total, weekly_change_percentage: weekly_change_percentage)
          .deliver_now
      end

      def weekly_change_percentage
        PercentageChange.new(previous: previous_portfolio.total, current: total).value
      end
    end
  end
end
