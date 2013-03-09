FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name.sub(/_|\./, '') }
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(8) }
  end

  factory :invalid_user, parent: :user do
    username nil
  end
end
