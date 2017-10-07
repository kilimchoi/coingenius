FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    username { FFaker::Internet.user_name }
    password "123456"
  end

  factory :user_with_transactions, parent: :user do
    after(:create) do |user|
      create(:transaction, :bought, user: user, amount: 1.2, price: 10.0)
      create(:transaction, :bought,
        user: user, amount: 1.5, price: 10.0,
        created_at: Time.now.beginning_of_week - 5.days
      )
      create(:transaction, :sold,
        user: user, amount: -0.8, price: 10.0,
        created_at: Time.now.beginning_of_week - 6.days
      )
    end
  end
end
