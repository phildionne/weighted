FactoryGirl.define do
  factory :source do
    location { Faker::Internet.url }

    factory :source_with_collections do
      ignore do
        collections_count 2
      end

      after(:create) do |source, evaluator|
        source.collections << FactoryGirl.create_list(:collection, evaluator.collections_count)
      end
    end
  end

  factory :invalid_source, parent: :source do
    location ""
  end
end
