require "rails_helper"

describe FormattedYearAndWeek do
  describe "#call" do
    let(:value_object) { described_class.new("01-03-2001".to_time) }

    it "returns formatted year and date" do
      expect(value_object.value).to eq("2001-09")
      expect(value_object.next).to eq("2001-10")
      expect(value_object.previous).to eq("2001-08")
    end
  end
end
