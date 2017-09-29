TYPES = Transaction.transaction_types

FactoryGirl.define do
  factory :transaction do
    coin { Coin.last || create(:coin) }
    user
    amount 100.0

    TYPES.keys.each do |type|
      trait type.to_sym do
        transaction_type { TYPES[type] }
      end
    end
  end
end
