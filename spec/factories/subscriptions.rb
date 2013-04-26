# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    stripe_card_token "MyString"
    customer_id 1
  end
end
