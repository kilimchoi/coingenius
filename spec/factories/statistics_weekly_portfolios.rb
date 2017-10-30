FactoryGirl.define do
  factory :statistics_weekly_portfolio, class: "Statistics::WeeklyPortfolio" do
    user
    total 1000.0
    week_number { FormattedYearAndWeek.new.value }
  end
end
