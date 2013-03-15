FactoryGirl.define do
  factory :collection do
    subject { Faker::Lorem.words(6).join(' ') }
    description { Faker::Lorem.sentence }

    factory :collection_with_contents do
      ignore do
        contents_count 5
      end

      after(:create) do |collection, evaluator|
        FactoryGirl.create_list(:content, evaluator.contents_count, collection: collection)
      end
    end

  end

  factory :invalid_collection, parent: :collection do
    description nil
    subject nil
  end
end
