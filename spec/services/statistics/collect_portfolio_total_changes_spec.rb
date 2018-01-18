require "rails_helper"

describe Statistics::CollectPortfolioTotalChanges do
  describe "#call" do
    let(:service_call) { described_class.call(user: user) }
    let(:user) { create(:user) }
    let(:today) { Time.zone.now }
    let(:week_ago) { 1.week.ago }
    let(:month_ago) { 1.month.ago }
    let(:year_ago) { 1.year.ago }

    before do
      allow(Coins::GetCachedPriceHistory)
        .to receive(:call)
        .and_return(double(results: {
                             today.beginning_of_day.to_i => 2000.0,
                             week_ago.beginning_of_day.to_i => 1000.0,
                             month_ago.beginning_of_day.to_i => 300.0,
                             year_ago.beginning_of_day.to_i => 3000.0
                           }))

      create(:transaction, :bought, user: user, amount: 1.0)
      create(:transaction, :bought, user: user, amount: 2.0)
    end

    it "creates weekly portfolio record" do
      weekly, monthly, yearly = service_call.results

      expect(weekly.difference).to eq(3000)
      expect(monthly.difference).to eq(5100)
      expect(yearly.difference).to eq(-3000)
      expect(weekly.percentage_difference).to eq(100.0)
      expect(monthly.percentage_difference).to eq(566.67)
      expect(yearly.percentage_difference).to eq(-33.33)
    end
  end
end
