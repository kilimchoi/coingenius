require "rails_helper"

describe FormattedYearAndWeek do
  describe "#call" do
    let(:value_object) { described_class.new("01-03-2001".to_time) }

    it "returns formatted year and date" do
      expect(value_object.value).to eq("2001-09")
      expect(value_object.next).to eq("2001-10")
      expect(value_object.previous).to eq("2001-08")
    end

    context "when handling start of the year" do
      let(:value_object) { described_class.new("01-01-2001".to_time) }

      it "returns formatted year and date" do
        expect(value_object.value).to eq("2001-01")
        expect(value_object.next).to eq("2001-02")
        expect(value_object.previous).to eq("2000-52")
      end
    end

    context "when handling end of the year" do
      let(:value_object) { described_class.new("31-12-2001".to_time) }

      it "returns formatted year and date" do
        expect(value_object.value).to eq("2002-01")
        expect(value_object.next).to eq("2002-02")
        expect(value_object.previous).to eq("2001-52")
      end
    end
  end
end
