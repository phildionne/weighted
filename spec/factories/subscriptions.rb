FactoryGirl.define do
  factory :subscription do
    user
  end

  factory :invalid_subscription, parent: :subscription do
    user nil
  end
end
