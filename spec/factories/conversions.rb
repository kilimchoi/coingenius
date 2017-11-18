FactoryGirl.define do
  factory :conversion do
    sending_coin_id nil
    receive_coin_id nil
    return_address { FFaker::DizzleIpsum.characters(16) }
    withdrawal_address { FFaker::DizzleIpsum.characters(16) }
    deposit_address { FFaker::DizzleIpsum.characters(16) }
    raw_data { {} }
  end
end
