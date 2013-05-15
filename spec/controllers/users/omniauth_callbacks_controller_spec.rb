require 'spec_helper'

describe Users::OmniauthCallbacksController do
  before { request.env["devise.mapping"] = Devise.mappings[:user] }

  describe :twitter do
    before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] }

    context "with an existing user" do
      before { @user = FactoryGirl.create(:oauth_user, provider: 'twitter', uid: '12345') }

      it "authenticates the user and redirect" do
        get :twitter

        should be_user_signed_in
        response.should be_redirect
      end

      it "updates user's avatar with auth informations" do
        @user.profile.update_attribute(:provider_avatar, 'old-avatar.jpg')
        get :twitter

        @user.profile.reload
        @user.profile.provider_avatar.should eq("http://a0.twimg.com/profile_images/test.jpeg")
      end
    end

    context "with a new user" do
      context "with all informations to create a new User" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] }

        it "authenticates the user and redirect" do
          get :twitter

          assigns(:user).should be_persisted
          should be_user_signed_in
          response.should be_redirect
        end
      end

      context "with insufficient informations to create a new User" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter_incomplete] }

        it "doesn't authenticates the user and redirect" do
          get :twitter

          assigns(:user).should_not be_persisted
          should_not be_user_signed_in
          response.should be_redirect
        end
      end
    end

  end
end
