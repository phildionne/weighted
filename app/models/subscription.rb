class Subscription < ActiveRecord::Base
  attr_accessible :customer_id, :stripe_card_token
end
