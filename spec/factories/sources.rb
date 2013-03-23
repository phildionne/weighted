FactoryGirl.define do
  factory :source do
    uri { Faker::Internet.url }
  end

  factory :source_with_collections, parent: :source do
    ignore do
      collections_count 2
    end

    after(:create) do |source, evaluator|
      FactoryGirl.create_list(:collection, evaluator.collections_count, source: source)
    end
  end

  factory :invalid_source, parent: :source do
    uri ""
  end
end
