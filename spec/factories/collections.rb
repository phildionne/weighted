# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :collection do
    name { Faker::Name.first_name }
    description { Faker::Lorem.sentence }
  end
end
