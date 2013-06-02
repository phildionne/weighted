require 'spec_helper'

describe FrontpageController do

  describe "GET show" do

    context "with an authenticated user" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        get :show
      end

      it "responds with success and render template" do
        response.should be_success
        response.should render_template :homepage
      end
    end

    context "with an unauthenticated user" do
      before { get :show }

      it "responds with success and render template" do
        response.should be_success
        response.should render_template :frontpage
      end
    end
  end

end
