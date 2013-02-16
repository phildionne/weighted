# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :content do
    title "MyString"
    body "MyText"
    source "MyString"
  end
end
