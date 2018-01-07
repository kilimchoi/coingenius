FactoryGirl.define do
  factory :binance_deposit, class: 'Binance::Deposit' do
    amount "9.99"
    raw_data ""
    executed_at "2018-01-07 17:36:45"
  end
end
