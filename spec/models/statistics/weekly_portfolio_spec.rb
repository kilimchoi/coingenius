require "rails_helper"

describe Statistics::WeeklyPortfolio, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end
end
