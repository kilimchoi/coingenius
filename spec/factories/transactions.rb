TYPES = Transaction.transaction_types

FactoryGirl.define do
  factory :transaction do
    coin { Coin.last || create(:coin) }
    user
    amount 1.5
    price 100.0
    transaction_date Time.zone.now.beginning_of_day

    TYPES.keys.each do |type|
      trait type.to_sym do
        transaction_type { TYPES[type] }
      end
    end
  end
end
