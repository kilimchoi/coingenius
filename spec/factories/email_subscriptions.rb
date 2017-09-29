FactoryGirl.define do
  factory :email_subscription do
    user

    trait :enabled do
      enabled true
    end

    EmailSubscription.kinds.keys.map(&:to_sym).each do |key|
      trait key do
        kind { key }
      end
    end
  end
end
