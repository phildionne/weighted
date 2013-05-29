class Subscription < ActiveRecord::Base
  include Stripe::Callbacks

  # @note Possible states are:
  #
  #   trialing
  #   active
  #   past_due
  #   canceled
  #   unpaid

  belongs_to :user

  # @note Presence validation of stripe_customer_id is ensured by #create_stripe_customer
  # @note Presence validation of stripe_card_last4 is ensured in the
  # SubscriptionController #update action
  #
  validates :user, presence: true

  before_create    :create_stripe_customer
  before_destroy   :destroy_stripe_customer

  # @TODO Decide what happens when a customer activates his subscription before the end of the trial
  # @TODO Decide wether to show trial begining and ending dates

  after_customer_subscription_created! do |stripe_subscription, event|
    subscription = Subscription.find_by_stripe_customer_id(stripe_subscription.customer)
    subscription.state = stripe_subscription.status
    subscription.save!
  end

  after_customer_subscription_updated! do |stripe_subscription, event|
    subscription = Subscription.find_by_stripe_customer_id(stripe_subscription.customer)
    subscription.state = stripe_subscription.status
    subscription.save!
  end

  after_customer_subscription_deleted! do |stripe_subscription, event|
    subscription = Subscription.find_by_stripe_customer_id(stripe_subscription.customer)
    subscription.state = stripe_subscription.status
    subscription.save!
  end

  after_customer_subscription_trial_will_end do |stripe_subscription, event|
  end

  after_customer_updated! do |stripe_customer, event|
    subscription = Subscription.find_by_stripe_customer_id(stripe_customer.id)
    subscription.state = event.data.object.subscription[:status]
    subscription.save!
  end


  # Convenience methods to query the Subscription state
  #
  # @return [Boolean]
  ['trialing?', 'active?', 'past_due?', 'canceled?', 'unpaid?'].each do |method_name|
    define_method(method_name) do
      state == method_name.chop
    end
  end


  private

  # Creates a Stripe customer, raises on failure
  def create_stripe_customer
    begin
      customer = Stripe::Customer.create(email: user.email, plan:  'default')
      self.stripe_customer_id = customer.id
    rescue Stripe::StripeError => e
      logger.error e
      raise e
    end
  end

  # Destroys a Stripe customer, raises on failure
  def destroy_stripe_customer
    begin
      customer = Stripe::Customer.retrieve(stripe_customer_id)
      customer.delete
    rescue Stripe::StripeError => e
      logger.error e
      raise e
    end
  end

end
