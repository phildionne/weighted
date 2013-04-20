require 'spec_helper'

describe FollowsController do
  include Devise::TestHelpers

  before do
    @collection = FactoryGirl.create(:collection)
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "POST create" do
    it "creates a new Follow" do
      expect {
        post :create, follow: { collection_id: @collection.id }
      }.to change(Follow, :count).by(1)
    end

    it "redirects to the collection" do
      post :create, follow: { collection_id: @collection.id }
      response.should redirect_to(@collection)
    end
  end

  describe "DELETE destroy" do
    before do
      @user.follow!(@collection)
      @follow = @user.follows.find_by_collection_id(@collection.id)
    end

    it "destroys the Follow" do
      expect {
        delete :destroy, id: @follow.id
      }.to change(Follow, :count).by(-1)
    end

    it "redirects to the collection" do
      delete :destroy, id: @follow.id
      response.should redirect_to(@collection)
    end
  end

end
