require 'spec_helper'

describe Settings::SubscriptionsController do
  let(:user) { FactoryGirl.create(:user_with_active_subscription) }
  let(:subscription) { user.subscription }
  before { sign_in user }

  describe "GET show" do
    before { get :show }

    it "assigns the user subscription as @subscription" do
      assigns(:subscription).should eq(subscription)
    end

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :show
    end
  end

  describe "PUT update" do
    let(:stripe_card) do
      Stripe::Token.create(
        :card => {
          :number => "4012888888881881",
          :exp_month => 5,
          :exp_year => 2020,
          :cvc => 1234
        }
      )
    end

    let(:invalid_stripe_card) do
      Stripe::Token.create(
        :card => {
          :number => "4242424242424241",
          :exp_month => 33,
          :exp_year => 4050,
          :cvc => 12
        }
      )
    end

    context "with valid params" do
      it "assigns the user subscription as @subscription" do
        put :update, { stripe_card_token: stripe_card.id }
        assigns(:subscription).should eq(subscription)
      end

      it "updates @subscription's attributes" do
        put :update, { stripe_card_token: stripe_card.id }

        subscription.reload
        subscription.stripe_card_last4.should eq('1881')
      end

      it "redirects to subscription path" do
        put :update, { stripe_card_token: stripe_card.id }
        response.should redirect_to(settings_subscription_path)
      end
    end

    context "with invalid params" do
      it "assigns the subscription as @subscription" do
        put :update, { stripe_card_token: invalid_stripe_card.id }
        assigns(:subscription).should eq(subscription)
      end

      it "does not update @subscription's attributes" do
        put :update, { stripe_card_token: invalid_stripe_card.id }
        subscription.reload
        subscription.stripe_card_last4.should eq('4242')
      end

      it "re-renders the 'show' template" do
        put :update, { stripe_card_token: invalid_stripe_card.id }
        response.should render_template :show
      end
    end
  end
end
