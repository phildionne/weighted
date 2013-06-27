require 'spec_helper'

describe ContentsController do
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "GET index" do
    let(:collection) { FactoryGirl.create(:collection_with_sources_and_contents) }

    before { get :index, { collection_id: collection } }

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :index
    end
  end

  describe "GET show" do
    let(:collection) { FactoryGirl.create(:collection_with_sources_and_contents) }
    let(:content) { collection.contents.first }

    before { get :show, id: content, collection_id: collection }

    it "assigns the content as @content" do
      assigns(:content).should eq(content)
    end

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :show
    end
  end

  describe "GET new" do
    let(:source) { FactoryGirl.create(:source) }

    before { get :new, source_id: source }

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :new
    end
  end

  describe "POST create" do
    context "with valid params" do
      let(:source) { FactoryGirl.create(:source) }
      let(:content_attributes) { FactoryGirl.attributes_for(:content) }

      it "creates a new Content" do
        expect {
          post :create, { content: content_attributes, source_id: source }
        }.to change(Content, :count).by(1)
      end

      it "assigns a newly created content as @content" do
        post :create, { content: content_attributes, source_id: source }
        assigns(:content).should be_a(Content)
        assigns(:content).should be_persisted
      end

      it "redirects to the created content" do
        post :create, { content: content_attributes, source_id: source }
        response.should redirect_to(source_content_path(source, Content.last))
      end
    end

    context "with invalid params" do
      let(:source) { FactoryGirl.create(:source) }
      let(:invalid_content_attributes) { FactoryGirl.attributes_for(:invalid_content) }

      before do
        post :create, { content: invalid_content_attributes, source_id: source }
      end

      it "assigns a newly created but unsaved content as @content" do
        assigns(:content).should be_a_new(Content)
      end

      it { should render_template :new }
    end
  end

  describe "DELETE destroy" do
    before { @source = FactoryGirl.create(:source_with_contents) }
    let(:content) { @source.contents.first }

    it "destroys the requested content" do
      expect {
        delete :destroy, { id: content, source_id: @source }
      }.to change(Content, :count).by(-1)
    end

    it "redirects to the contents list" do
      delete :destroy, { id: content, source_id: @source }
      response.should redirect_to(source_contents_path)
    end
  end

end
