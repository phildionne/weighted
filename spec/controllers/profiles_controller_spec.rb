require 'spec_helper'

describe Settings::ProfilesController do
  include Devise::TestHelpers

  describe "GET show" do
    it "assigns the user profile as @profile" do
      @user = FactoryGirl.create(:user)
      sign_in @user

      get :show
      assigns(:profile).should eq(@user.profile)
    end
  end

  describe "GET edit" do
    it "assigns the user profile as @profile" do
      @user = FactoryGirl.create(:user)
      sign_in @user

      get :edit
      assigns(:profile).should eq(@user.profile)
    end
  end

  describe "PUT update" do

    before :each do
      @user = FactoryGirl.create(:user)
      sign_in @user

      @profile = @user.profile
    end

    it "assigns the user profile as @profile" do
      put :update
      assigns(:profile).should eq(@profile)
    end

    context "with valid params" do
      it "updates @profile's attributes" do
        put :update, { profile: FactoryGirl.attributes_for(:profile, name: "Dalai Lama", gravatar_email: "test@gravatar.com") }
        assigns(:profile).should eq(@profile)
      end

      it "assigns the requested profile as @profile" do
        put :update, { profile: FactoryGirl.attributes_for(:profile, name: "Dalai Lama", gravatar_email: "test@gravatar.com") }
        @profile.reload
        @profile.name.should eq("Dalai Lama")
        @profile.gravatar_email.should eq("test@gravatar.com")
      end

      it "redirects to profile path" do
        put :update, { profile: FactoryGirl.attributes_for(:profile) }
        response.should redirect_to(settings_profile_path)
      end
    end

    context "with invalid params" do
      it "assigns the profile as @profile" do
        put :update, { id: @profile, profile: FactoryGirl.attributes_for(:invalid_profile) }
        assigns(:profile).should eq(@profile)
      end

      it "does not assigns the requested profile as @profile" do
        put :update, { id: @profile, profile: FactoryGirl.attributes_for(:invalid_profile, name: "Napoleon", first_name: "The Great") }
        @profile.reload
        @profile.name.should_not eq("Napoleon")
        @profile.first_name.should_not eq("The Great")
      end

      it "re-renders the 'edit' template" do
        put :update, { id: @profile, profile: FactoryGirl.attributes_for(:invalid_profile) }
        response.should render_template :edit
      end
    end
  end

end
