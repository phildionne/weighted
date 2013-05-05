FactoryGirl.define do
  factory :subscription do
    user
  end

  factory :active_subscription, parent: :subscription do
    after(:create) do |subscription|
      stripe_customer = Stripe::Customer.retrieve(subscription.stripe_customer_id)
      card = Stripe::Token.create(
                :card => {
                  :number => "4242424242424242",
                  :exp_month => 5,
                  :exp_year => 2020,
                  :cvc => 1234
                }
              )

      stripe_customer.card = card.id
      stripe_customer.save
      subscription.stripe_card_last4 = stripe_customer.active_card.last4
      subscription.save
    end
  end

  factory :invalid_subscription, parent: :subscription do
    user nil
  end
end
