# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    user
    name { Faker::Internet.user_name }
    gravatar_email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    avatar { Faker::Internet.url }
  end
end
