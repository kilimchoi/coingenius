# Preview all emails at http://localhost:3000/rails/mailers/weekly_report_mailer
class WeeklyReportMailerPreview < ActionMailer::Preview
  def weekly_report_preview
    WeeklyReportMailer.weekly_report(User.first)
  end
end
