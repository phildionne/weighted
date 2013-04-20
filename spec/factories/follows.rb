FactoryGirl.define do
  factory :follow do
    user
    collection
  end

  factory :invalid_follow, parent: :follow do
    user nil
    collection nil
  end
end
