FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name.sub(/_|\./, '') }
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(8) }
  end

  factory :user_with_followed_collections, parent: :user do
    ignore do
      collection_count [3, 4, 5].sample
    end

    after(:create) do |user, evaluator|
      FactoryGirl.create_list(:collection, evaluator.collection_count).each do |collection|
        user.follow!(collection)
      end
    end
  end

  factory :invalid_user, parent: :user do
    username nil
  end
end
