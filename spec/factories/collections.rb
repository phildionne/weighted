FactoryGirl.define do
  factory :collection do
    subject     { Faker::Lorem.words(6).join(' ') }
    description { Faker::Lorem.sentence }
  end

  factory :collection_with_sources, parent: :collection do
    ignore do
      sources_count [1,2,3].sample
    end

    after(:create) do |collection, evaluator|
      collection.sources << FactoryGirl.create_list(:source, evaluator.sources_count)
    end
  end

  factory :collection_with_sources_and_contents, parent: :collection do
    ignore do
      sources_count [1,2,3].sample
    end

    after(:create) do |collection, evaluator|
      sources = FactoryGirl.create_list(:source_with_contents, evaluator.sources_count)
      collection.sources << sources
      collection.save
    end
  end

  factory :collection_with_followers, parent: :collection do
    ignore do
      users_count [1,2,3].sample
    end

    after(:create) do |collection, evaluator|
      FactoryGirl.create_list(:user, evaluator.users_count).each do |user|
        user.follow!(collection)
      end
    end
  end

  factory :invalid_collection, parent: :collection do
    description nil
    subject nil
  end
end
