FactoryGirl.define do
  factory :user do
    username  { Faker::Internet.user_name.sub(/_|\./, '') }
    email     { Faker::Internet.email }
    password  { Faker::Lorem.characters(8) }
  end

  factory :oauth_user, parent: :user do
    uid      12345
    provider 'twitter'
    password nil
  end

  factory :user_with_followed_collections, parent: :user do
    ignore do
      collection_count [3, 4, 5].sample
    end

    after(:create) do |user, evaluator|
      FactoryGirl.create_list(:collection, evaluator.collection_count).each do |collection|
        user.follow!(collection)
      end
    end
  end

  factory :user_with_active_subscription, parent: :user do
    after(:create) do |user|
      subscription = user.subscription

      stripe_customer = Stripe::Customer.retrieve(subscription.stripe_customer_id)
      stripe_card = Stripe::Token.create(card: {
                                          :number    => "4242424242424242",
                                          :exp_month => 5,
                                          :exp_year  => 2020,
                                          :cvc       => 1234
                                        }
                                      )

      stripe_customer.card = stripe_card.id
      subscription.stripe_card_last4 = stripe_card.card.last4
      subscription.save
    end
  end

  factory :invalid_user, parent: :user do
    username nil
  end
end
