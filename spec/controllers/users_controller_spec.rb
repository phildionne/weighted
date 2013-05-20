require 'spec_helper'

describe UsersController do

  describe "GET show" do
    let(:user) { FactoryGirl.create(:user) }

    before { get :show, id: user.id }

    it "assigns the user as @user" do
      assigns(:user).should eq(user)
    end

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :show
    end
  end

  describe "GET followed_collections" do
    let(:user) { FactoryGirl.create(:user_with_followed_collections) }
    let(:collections) { user.followed_collections }

    before { get :followed_collections, id: user }

    it "assigns the followed collections as @collections" do
      assigns(:collections).should eq(collections)
    end

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :followed_collections
    end
  end

end
