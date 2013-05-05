class Subscription < ActiveRecord::Base

  attr_protected :stripe_customer_id

  belongs_to :user

  validates :user, presence: true
  validates :stripe_customer_id, presence: true, on: :update
end
