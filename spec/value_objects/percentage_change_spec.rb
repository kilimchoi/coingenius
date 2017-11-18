require "rails_helper"

describe PercentageChange do
  let(:value_object) { described_class.new(previous: 500.0, current: 1000.0) }

  describe "#value" do
    it { expect(value_object.value).to eq(100.0) }
  end
end
