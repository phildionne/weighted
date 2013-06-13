require 'spec_helper'

describe SourcesController do
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "GET index" do
    let(:collection) { FactoryGirl.create(:collection_with_sources) }

    before { get :index, { collection_id: collection } }

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :index
    end
  end

  describe "GET show" do
    let(:collection) { FactoryGirl.create(:collection_with_sources) }
    let(:source) { collection.sources.first }

    before { get :show, id: source, collection_id: collection }

    it "assigns the source as @source" do
      assigns(:source).should eq(source)
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
    let(:source) { FactoryGirl.create(:source) }

    before { get :edit, id: source }

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :edit
    end
  end

  describe "POST create" do
    context "with valid params" do
      let(:source_attributes) { FactoryGirl.attributes_for(:source) }

      it "creates a new Source" do
        expect {
          post :create, { source: source_attributes }
        }.to change(Source, :count).by(1)
      end

      it "assigns a newly created source as @source" do
        post :create, { source: source_attributes }
        assigns(:source).should be_a(Source)
        assigns(:source).should be_persisted
      end

      it "redirects to the created source" do
        post :create, { source: source_attributes }
        response.should redirect_to(Source.last)
      end
    end

    context "with invalid params" do
      before { post :create, FactoryGirl.attributes_for(:invalid_source) }

      it "assigns a newly created but unsaved source as @source" do
        assigns(:source).should be_a_new(Source)
      end

      it { should render_template :new }
    end
  end

  describe "PUT update" do
    let(:source) { FactoryGirl.create(:source, location: "http://google.com") }

    context "with valid params" do
      it "assigns the requested source as @source" do
        put :update, { id: source, source: FactoryGirl.attributes_for(:source)}
        assigns(:source).should eq(source)
      end

      it "updates the requested source" do
        put :update, { id: source, source: FactoryGirl.attributes_for(:source, location: "http://google.com") }
        source.reload
        source.location.should eq("http://google.com")
      end

      it "redirects to the source" do
        put :update, { id: source, source: FactoryGirl.attributes_for(:source) }
        response.should redirect_to(source)
      end
    end

    context "with invalid params" do
      it "assigns the source as @source" do
        put :update, { id: source, source: FactoryGirl.attributes_for(:invalid_source) }
        assigns(:source).should eq(source)
      end

      it "does not update @source's attributes" do
        put :update, { id: source, source: FactoryGirl.attributes_for(:invalid_source, location: "invalid.url") }
        source.reload
        source.location.should_not eq("invalid.url")
        source.location.should eq("http://google.com")
      end

      it "re-renders the 'edit' template" do
        put :update, { id: source, source: FactoryGirl.attributes_for(:invalid_source) }
        response.should render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before { @source = FactoryGirl.create(:source) }

    it "destroys the requested source" do
      expect {
        delete :destroy, { id: @source }
      }.to change(Source, :count).by(-1)
    end

    it "redirects to the sources list" do
      delete :destroy, { id: @source }
      response.should redirect_to(sources_path)
    end
  end

end
