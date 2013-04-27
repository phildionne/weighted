module Weighted
  class Application

    if Rails.env.production?
      config.stripe.api_key         = ENV['STRIPE_SECRET_KEY']
      config.stripe.publishable_key = ENV['STRIPE_PUBLIC_KEY']
    else
      config.stripe.api_key         = ENV['STRIPE_SECRET_KEY_TEST']
      config.stripe.publishable_key = ENV['STRIPE_PUBLIC_KEY_TEST']
    end
  end
end
