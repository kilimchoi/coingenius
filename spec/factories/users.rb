FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    username { FFaker::Internet.user_name }
    password "123456"
  end

  factory :user_with_transactions, parent: :user do
    after(:create) do |user|
      create(:transaction, :bought, user: user, amount: 50.0)
      create(:transaction, :sold, user: user, amount: -20.0, created_at: Time.now.beginning_of_week - 1.week)
    end
  end
end
