require "rails_helper"

describe WeeklyUserTransactionsGroups::CalculateTotalPrice do
  describe "#call" do
    let(:coin) { transaction.coin }
    let(:service_call) { described_class.call(transactions_group: transactions_group) }
    let(:timestamp) { Time.zone.now.beginning_of_day.to_i }
    let(:total_price) { transaction.amount * 5000.0 }
    let(:transactions_group) { WeeklyUserTransactionsGroup.last }
    let!(:transaction) { create(:transaction, :bought) }

    it "calculates total price" do
      expect(Coins::GetCachedPriceHistory)
        .to receive(:call)
        .with(coin: coin, days: 1, price_currency: "USD")
        .and_return(double(results: { timestamp => "5000.0" }))
      expect(service_call).to be_success
      expect(service_call.total_price).to eq(total_price)
    end
  end
end
