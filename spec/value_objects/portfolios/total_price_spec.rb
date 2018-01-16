require "rails_helper"

describe Portfolios::TotalMoneyPrice do
  let(:transactions_group) { WeeklyUserTransactionsGroup.last }
  let(:datetime) { Time.zone.now }
  let(:value_object) do
    described_class.new(coin: transactions_group.coin, total_amount: transactions_group.total_amount, datetime: datetime)
  end

  before do
    allow(Coins::GetCachedPriceHistory)
      .to receive(:call)
      .and_return(double(results: { Time.zone.now.beginning_of_day.to_i => 5000.0 }))
    create(:transaction, :bought, amount: 1.3)
    WeeklyUserTransactionsGroup.refresh
  end

  describe "#value" do
    it { expect(value_object.value).to eq(6500.0) }
  end
end
