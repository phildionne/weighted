FactoryGirl.define do
  factory :source do
    location { Faker::Internet.url }
  end

  factory :source_with_contents, parent: :source do
    ignore do
      contents_count [1,2,3].sample
    end

    after(:create) do |source, evaluator|
      source.contents << FactoryGirl.create_list(:content, evaluator.contents_count)
    end
  end

  factory :invalid_source, parent: :source do
    location ""
  end
end
