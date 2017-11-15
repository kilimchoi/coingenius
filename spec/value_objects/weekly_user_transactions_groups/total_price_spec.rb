require "rails_helper"

describe WeeklyUserTransactionsGroups::TotalPrice do
  let(:transactions_group) { WeeklyUserTransactionsGroup.last }
  let(:datetime) { Time.zone.now }
  let(:value_object) { described_class.new(transactions_group: transactions_group, datetime: datetime) }

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
