class Subscription < ActiveRecord::Base

  attr_protected :stripe_customer_id

  belongs_to :user

  validates :user, presence: true
  validates :stripe_customer_id, presence: true, on: :update
  before_validation :create_stripe_customer, on: :create
  before_destroy    :destroy_stripe_customer
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
