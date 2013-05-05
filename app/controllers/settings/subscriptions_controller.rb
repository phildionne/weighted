class Settings::SubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  # GET /settings/subscription
  # GET /settings/subscription.json
  def show
    @subscription = Subscription.find_by_user_id(current_user)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscription }
    end
  end

  # PUT /settings/subscription
  # PUT /settings/subscription.json
  def update
    @subscription = Subscription.find_by_user_id(current_user)

    begin
      stripe_customer = Stripe::Customer.retrieve(@subscription.stripe_customer_id)
      stripe_customer.card = params[:stripe_card_token]
      stripe_customer.save
    rescue Stripe::StripeError => e
      logger.error e

      @subscription.errors.add :base, 'There was a problem with your credit card'

      respond_to do |format|
        format.html { render action: "show" }
        format.json { status :unprocessable_entity }
      end
    end

    @subscription.stripe_card_last4 = stripe_customer.active_card.last4
    @subscription.save!

    respond_to do |format|
      format.html { redirect_to settings_subscription_path, notice: 'Thank you for subscribing!' }
      format.json { head :no_content }
    end
  end

end
