class Subscription < ActiveRecord::Base
  include Stripe::Callbacks

  attr_protected :stripe_customer_id
  # @note Possible states are:
  #
  #   trialing
  #   active
  #   past_due
  #   canceled
  #   unpaid

  belongs_to :user

  validates :user, presence: true
  validates :stripe_customer_id, presence: true, on: :update
  before_validation :create_stripe_customer, on: :create
  before_destroy    :destroy_stripe_customer
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



  # Convenience methods to query the subscription state
  #
  # @return [Boolean]
  ['trialing?', 'active?', 'past_due?', 'canceled?', 'unpaid?'].each do |method|
    define_method(method) do
      state == method.chop
    end
  end


  private

  # Creates a Stripe customer, raises on failure
  def create_stripe_customer
    begin
      customer = Stripe::Customer.create(email: user.email,
                                         plan:  'default')
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
