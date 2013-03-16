FactoryGirl.define do
  factory :profile do
    user

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    gravatar_email { Faker::Internet.email }
    provider_avatar { Faker::Internet.url + '.png' }
  end

  factory :invalid_profile, parent: :profile do
    gravatar_email "not an email"
    first_name { Faker::Lorem.characters(100) }
    last_name { Faker::Lorem.characters(100) }
  end
end
