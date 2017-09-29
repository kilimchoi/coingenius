FactoryGirl.define do
  factory :coin do
    symbol "BTC"
    description { FFaker::Lorem.phrase }
    website "https://btc.com"
  end
end
