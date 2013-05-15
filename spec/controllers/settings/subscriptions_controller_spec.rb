require 'spec_helper'

describe Settings::SubscriptionsController do
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "GET show" do
    it "assigns the user subscription as @subscription" do
      get :show
      assigns(:subscription).should eq(user.subscription)
    end
  end

  describe "PUT update" do
    let(:subscription) { user.subscription }

    it "assigns the user subscription as @subscription" do
      put :update
      assigns(:subscription).should eq(subscription)
    end

    context "with valid params" do
      it "updates @subscription's attributes" do
        put :update, { subscription: FactoryGirl.attributes_for(:subscription, first_name: "Dalai Lama", gravatar_email: "test@gravatar.com") }
        assigns(:subscription).should eq(subscription)
      end

      it "assigns the requested subscription as @subscription" do
        pending
        # put :update, { subscription: FactoryGirl.attributes_for(:subscription, first_name: "Dalai Lama", gravatar_email: "test@gravatar.com") }
        # subscription.reload
        # subscription.first_name.should eq("Dalai Lama")
        # subscription.gravatar_email.should eq("test@gravatar.com")
      end

      it "redirects to subscription path" do
        pending
        # put :update, { subscription: FactoryGirl.attributes_for(:subscription) }
        # response.should redirect_to(settings_subscription_path)
      end
    end

    context "with invalid params" do
      it "assigns the subscription as @subscription" do
        put :update, { id: subscription, subscription: FactoryGirl.attributes_for(:invalid_subscription) }
        assigns(:subscription).should eq(subscription)
      end

      it "does not assigns the requested subscription as @subscription" do
        pending
        # put :update, { id: subscription, subscription: FactoryGirl.attributes_for(:invalid_subscription, first_name: "The Great", last_name: "Napoleon") }
        # subscription.reload
        # subscription.last_name.should_not eq("Napoleon")
        # subscription.first_name.should_not eq("The Great")
      end

      it "re-renders the 'show' template" do
        pending
        # put :update, { id: subscription, subscription: FactoryGirl.attributes_for(:invalid_subscription) }
        # response.should render_template :show
      end
    end
  end
end
