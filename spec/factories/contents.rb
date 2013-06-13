FactoryGirl.define do
  factory :content do
    source

    title     { Faker::Lorem.words(8).join(' ') }
    body      { Faker::Lorem.paragraphs.join(' ') }
    location  { Faker::Internet.url }
  end

  factory :invalid_content, parent: :content do
    location nil
    body nil
    title nil
  end
end
