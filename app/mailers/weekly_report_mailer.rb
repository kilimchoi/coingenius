class WeeklyReportMailer < ApplicationMailer
  default from: "kilim@coingenius.co"
  def weekly_report(user_id)
    @user = User.find(user_id)
    @total = @user.holdings.last 
    mail(to: @user.email, subject: "Your CoinGenius portfolio", body: "Your total: #{@total}", content_type: "text/html")
  end
end
