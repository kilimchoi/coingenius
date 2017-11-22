require 'rails_helper'

RSpec.describe Conversion, type: :model do
  it { is_expected.to validate_presence_of :amount }
  it { is_expected.to validate_presence_of :deposit_address }
  it { is_expected.to validate_presence_of :max_amount }
  it { is_expected.to validate_presence_of :min_amount }
  it { is_expected.to validate_presence_of :rate }
  it { is_expected.to validate_presence_of :withdrawal_address }

  it { is_expected.to belong_to(:receive_coin).class_name("Coin") }
  it { is_expected.to belong_to(:sending_coin).class_name("Coin") }
end
