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

    factory :collection_with_sources do
      ignore do
        sources_count 5
      end

      after(:create) do |collection, evaluator|
        sources = FactoryGirl.create(:source, evaluator.sources_count)
        collection.sources << sources
      end
    end

    factory :collection_with_sources_and_contents do
      ignore do
        contents_count 10
        sources_count 2
      end

      after(:create) do |collection, evaluator|
        FactoryGirl.create_list(:content, evaluator.contents_count, collection: collection)

        sources = FactoryGirl.create_list(:source, evaluator.sources_count)
        collection.sources << sources
      end
    end

  end

  factory :invalid_collection, parent: :collection do
    description nil
    subject nil
  end
end
