require 'spec_helper'

describe Settings::ProfilesController do
  let(:user) { FactoryGirl.create(:user) }
  let(:profile) { user.profile }
  before { sign_in user }

  describe "GET show" do
    before { get :show }

    it "assigns the user profile as @profile" do
      assigns(:profile).should eq(profile)
    end

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :show
    end
  end

  describe "PUT update" do
    context "with valid params" do
      it "assigns the requested profile as @profile" do
        put :update, { profile: FactoryGirl.attributes_for(:profile, first_name: "Dalai Lama", gravatar_email: "test@gravatar.com") }
        assigns(:profile).should eq(profile)
      end

      it "updates @profile's attributes" do
        put :update, { profile: FactoryGirl.attributes_for(:profile, first_name: "Dalai Lama", gravatar_email: "test@gravatar.com") }
        profile.reload
        profile.first_name.should eq("Dalai Lama")
        profile.gravatar_email.should eq("test@gravatar.com")
      end

      it "redirects to profile path" do
        put :update, { profile: FactoryGirl.attributes_for(:profile) }
        response.should redirect_to(settings_profile_path)
      end
    end

    context "with invalid params" do
      it "assigns the profile as @profile" do
        put :update, { id: profile, profile: FactoryGirl.attributes_for(:invalid_profile) }
        assigns(:profile).should eq(profile)
      end

      it "does not update @profile's attributes" do
        put :update, { id: profile, profile: FactoryGirl.attributes_for(:invalid_profile, first_name: "The Great", last_name: "Napoleon") }
        profile.reload
        profile.last_name.should_not eq("Napoleon")
        profile.first_name.should_not eq("The Great")
      end

      it "re-renders the 'show' template" do
        put :update, { id: profile, profile: FactoryGirl.attributes_for(:invalid_profile) }
        response.should render_template :show
      end
    end
  end

end
