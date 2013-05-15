require 'spec_helper'

describe FollowsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:collection) { FactoryGirl.create(:collection) }
  before { sign_in user }

  describe "POST create" do
    context "with ajax" do
      it "creates a new Follow" do
        expect {
          xhr :post, :create, follow: { collection_id: collection.id }
        }.to change(Follow, :count).by(1)
      end

      it "responds with success" do
        xhr :post, :create, follow: { collection_id: collection.id }
        response.should be_success
      end
    end

    context "without ajax" do
      it "creates a new Follow" do
        expect {
          post :create, follow: { collection_id: collection.id }
        }.to change(Follow, :count).by(1)
      end

      it "redirects to the collection" do
        post :create, follow: { collection_id: collection.id }
        response.should redirect_to(collection)
      end
    end
  end

  describe "DELETE destroy" do
    before do
      user.follow!(collection)
    end

    let(:follow) { user.follows.find_by_collection_id(collection.id) }

    context "with ajax" do
      it "destroys the Follow" do
        expect {
          xhr :delete, :destroy, id: follow.id
        }.to change(Follow, :count).by(-1)
      end

      it "responds with success" do
        xhr :delete, :destroy, id: follow.id
        response.should be_success
      end
    end

    context "without ajax" do
      it "destroys the Follow" do
        expect {
          delete :destroy, id: follow.id
        }.to change(Follow, :count).by(-1)
      end

      it "redirects to the collection" do
        delete :destroy, id: follow.id
        response.should redirect_to(collection)
      end
    end

  end
end
