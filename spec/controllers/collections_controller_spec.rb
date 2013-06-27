require 'spec_helper'

describe CollectionsController do
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "GET index" do
    before { get :index }

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :index
    end
  end

  describe "GET show" do
    let(:collection) { FactoryGirl.create(:collection) }

    before { get :show, id: collection }

    it "assigns the user collection as @collection" do
      assigns(:collection).should eq(collection)
    end

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :show
    end
  end

  describe "GET new" do
    before { get :new }

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :new
    end
  end

  describe "GET edit" do
    let(:collection) { FactoryGirl.create(:collection) }

    before { get :edit, id: collection }

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :edit
    end
  end

  describe "POST create" do
    context "with valid params" do
      let(:collection_attributes) { FactoryGirl.attributes_for(:collection) }

      it "creates a new Collection" do
        expect {
          post :create, { collection: collection_attributes }
        }.to change(Collection, :count).by(1)
      end

      it "assigns a newly created collection as @collection" do
        post :create, { collection: collection_attributes }
        assigns(:collection).should be_a(Collection)
        assigns(:collection).should be_persisted
      end

      it "redirects to the created collection" do
        post :create, { collection: collection_attributes }
        response.should redirect_to(Collection.last)
      end
    end

    context "with invalid params" do
      before { post :create, FactoryGirl.attributes_for(:invalid_collection) }

      it "assigns a newly created but unsaved collection as @collection" do
        assigns(:collection).should be_a_new(Collection)
      end

      it { should render_template :new }
    end
  end

  describe "PUT update" do
    let(:collection) { FactoryGirl.create(:collection, subject: "Bacon", description: "Is so tasty!") }

    context "with valid params" do
      it "assigns the requested collection as @collection" do
        put :update, { id: collection, collection: FactoryGirl.attributes_for(:collection)}
        assigns(:collection).should eq(collection)
      end

      it "updates the requested collection" do
        put :update, { id: collection, collection: FactoryGirl.attributes_for(:collection, subject: "Poutine", description: "Is so tasty!") }
        collection.reload
        collection.subject.should eq("Poutine")
        collection.description.should eq("Is so tasty!")
      end

      it "redirects to the collection" do
        put :update, { id: collection, collection: FactoryGirl.attributes_for(:collection) }
        collection.reload
        response.should redirect_to(collection)
      end
    end

    context "with invalid params" do
      it "assigns the collection as @collection" do
        put :update, { id: collection, collection: FactoryGirl.attributes_for(:invalid_collection) }
        assigns(:collection).should eq(collection)
      end

      it "does not update @collection's attributes" do
        put :update, { id: collection, collection: FactoryGirl.attributes_for(:invalid_collection, subject: "Poutine") }
        collection.reload
        collection.subject.should_not eq("Poutine")
        collection.description.should eq("Is so tasty!")
      end

      it "re-renders the 'edit' template" do
        put :update, { id: collection, collection: FactoryGirl.attributes_for(:invalid_collection) }
        response.should render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before { @collection = FactoryGirl.create(:collection) }

    it "destroys the requested collection" do
      expect {
        delete :destroy, { id: @collection }
      }.to change(Collection, :count).by(-1)
    end

    it "redirects to the collections list" do
      delete :destroy, { id: @collection }
      response.should redirect_to(collections_path)
    end
  end

  describe "GET followers" do
    let(:collection) { FactoryGirl.create(:collection_with_followers) }
    let(:users) { collection.followers }

    before { get :followers, id: collection }

    it "assigns the followers as @users" do
      assigns(:users).should eq(users)
    end

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :followers
    end
  end

end
