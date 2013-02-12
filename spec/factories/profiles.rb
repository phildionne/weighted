# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    user
    gravatar_email "MyString"
    first_name "MyString"
    last_name "MyString"
    avatar "MyString"
  end
end
