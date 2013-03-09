require 'spec_helper'

describe CollectionsController do
  include Devise::TestHelpers

  before :each do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET index" do
    it "assigns all collections as @collections" do
      @collection = FactoryGirl.create(:collection)

      get :index, {}
      assigns(:collections).should eq([@collection])
    end
  end

  describe "GET show" do
    it "assigns the requested collection as @collection" do
      @collection = FactoryGirl.create(:collection)

      get :show, { id: @collection }
      assigns(:collection).should eq(@collection)
    end
  end

  describe "GET new" do
    it "assigns a new collection as @collection" do
      get :new
      assigns(:collection).should be_a_new(Collection)
    end
  end

  describe "GET edit" do
    it "assigns the requested collection as @collection" do
      @collection = FactoryGirl.create(:collection)

      get :edit, { id: @collection }
      assigns(:collection).should eq(@collection)
    end
  end

  describe "POST create" do
    context "with valid params" do

      before :each do
        @collection_attributes = FactoryGirl.attributes_for(:collection)
      end

      it "creates a new Collection" do
        expect {
          post :create, { collection: @collection_attributes }
        }.to change(Collection, :count).by(1)
      end

      it "assigns a newly created collection as @collection" do
        post :create, { collection: @collection_attributes }
        assigns(:collection).should be_a(Collection)
        assigns(:collection).should be_persisted
      end

      it "redirects to the created collection" do
        post :create, { collection: @collection_attributes }
        response.should redirect_to(Collection.last)
      end
    end

    context "with invalid params" do

      before :each do
        @invalid_collection_attributes = FactoryGirl.attributes_for(:invalid_collection)
      end

      it "assigns a newly created but unsaved collection as @collection" do
        post :create, @invalid_collection_attributes
        assigns(:collection).should be_a_new(Collection)
      end

      it "re-renders the 'new' template" do
        post :create, @invalid_collection_attributes
        response.should render_template :new
      end
    end
  end

  describe "PUT update" do

    before :each do
      @collection = FactoryGirl.create(:collection, name: "Bacon", description: "Is so tasty!")
    end

    context "with valid params" do
      it "updates the requested collection" do
        put :update, { id: @collection, collection: FactoryGirl.attributes_for(:collection)}
        assigns(:collection).should eq(@collection)
      end

      it "assigns the requested collection as @collection" do
        put :update, { id: @collection, collection: FactoryGirl.attributes_for(:collection, name: "Poutine", description: "Is so tasty!") }
        @collection.reload
        @collection.name.should eq("Poutine")
        @collection.description.should eq("Is so tasty!")
      end

      it "redirects to the collection" do
        put :update, { id: @collection, collection: FactoryGirl.attributes_for(:collection) }
        response.should redirect_to(@collection)
      end
    end

    context "with invalid params" do
      it "assigns the collection as @collection" do
        put :update, { id: @collection, collection: FactoryGirl.attributes_for(:invalid_collection) }
        assigns(:collection).should eq(@collection)
      end

      it "does not assigns the requested collection as @collection" do
        put :update, { id: @collection, collection: FactoryGirl.attributes_for(:invalid_collection, name: "Poutine") }
        @collection.reload
        @collection.name.should_not eq("Poutine")
        @collection.description.should eq("Is so tasty!")
      end

      it "re-renders the 'edit' template" do
        put :update, { id: @collection, collection: FactoryGirl.attributes_for(:invalid_collection) }
        response.should render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before :each do
      @collection = FactoryGirl.create(:collection)
    end

    it "destroys the requested collection" do
      expect {
        delete :destroy, { id: @collection }
      }.to change(Collection, :count).by(-1)
    end

    it "redirects to the collections list" do
      delete :destroy, { id: @collection }
      response.should redirect_to(collections_url)
    end
  end

end
