FactoryGirl.define do
  factory :source do
    uri { Faker::Internet.url }

    factory :source_with_collections do
      ignore do
        collections_count 2
      end

      after(:create) do |source, evaluator|
        FactoryGirl.create_list(:collection, evaluator.collections_count, source: source)
      end
    end
  end

  factory :invalid_source, parent: :source do
    uri ""
  end
end
