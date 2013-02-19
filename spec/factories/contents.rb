# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :content do
    title { Faker::Lorem.words(8) }
    body { Faker::Lorem.paragraphs }
    source { Faker::Internet.url }
  end
end
