require 'spec_helper'

describe UsersController do

  describe "GET show" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      get :show, { id: user }
    end

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :show
    end
  end

  describe "GET followed_collections" do
    let(:user) { FactoryGirl.create(:user_with_followed_collections) }

    before do
      get :followed_collections, { id: user }
    end

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :followed_collections
    end
  end

end
