require "rails_helper"

describe "Weekly Portfolio", type: :feature do
  let(:coin) { create(:coin) }
  let(:timestamp) { Time.zone.now.beginning_of_day.to_i }
  let(:user) { create(:user) }
  let(:week_start) { Time.zone.now.beginning_of_week }
  let(:previous_timestamp) { (week_start - 1.week).to_i }
  let(:previous_price) { "5000.0" }
  let(:current_price) { "6000.0" }
  let(:weekly_portfolio) do
    Statistics::WeeklyPortfolio.find_by(
      user: user,
      week_number: FormattedYearAndWeek.new(week_start).value
    )
  end

  shared_examples "sending email and creating new portfolio record" do
    it do
      expect(Users::WeeklyPortfolioReportMailer)
        .to receive(:send_email)
        .with(user: user, total: total, weekly_change_percentage: change)
        .and_return(instance_double("Users::WeeklyPortfolioReportMailer", deliver_now: true))
      Users::WeeklyPortfolio::Create.call(user: user)
      expect(weekly_portfolio.reload.total).to eq(total)
    end
  end

  before do
    allow(Coins::GetCachedPriceHistory)
      .to receive(:call)
      .and_return(previous_timestamp => previous_price, timestamp => current_price)
  end

  context "user has transactions every and coin rates has been changed" do
    let(:total) { 12_000.0 }
    let(:change) { 140.0 }

    before do
      Timecop.freeze(week_start - 1.week) do
        create(:transaction, :bought,
          amount: 1.0, user: user, coin: coin,
          price: 5000.0)
        Statistics::CreateWeeklyPortfolio.call(user: user)
      end
      create(:transaction, :bought,
        amount: 1.0, user: user, coin: coin,
        price: 6000.0, transaction_date: week_start)
    end

    include_examples "sending email and creating new portfolio record"
  end

  context "user with old transaction" do
    let(:total) { 6000.0 }
    let(:change) { 20.0 }

    before do
      create(:transaction, :bought,
        amount: 1.0, user: user, coin: coin,
        price: 1000.0, transaction_date: 1.year.ago)
      Timecop.freeze(week_start - 1.week) do
        Statistics::CreateWeeklyPortfolio.call(user: user)
      end
    end

    include_examples "sending email and creating new portfolio record"
  end

  context "user has transactions every and coin rates hasn't changed" do
    let(:current_price) { "5000.0" }
    let(:total) { 10_000.0 }
    let(:change) { 100.0 }

    before do
      Timecop.freeze(week_start - 1.week) do
        create(:transaction, :bought,
          amount: 1.0, user: user, coin: coin,
          price: 5000.0)
        Statistics::CreateWeeklyPortfolio.call(user: user)
      end
      create(:transaction, :bought,
        amount: 1.0, user: user, coin: coin,
        price: 5000.0, transaction_date: week_start)
    end

    include_examples "sending email and creating new portfolio record"
  end
end
