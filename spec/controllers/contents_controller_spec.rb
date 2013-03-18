require 'spec_helper'

describe ContentsController do
  include Devise::TestHelpers

  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET index" do
    before do
      @collection = FactoryGirl.create(:collection_with_contents)
      get :index, { collection_id: @collection }
    end
    subject { controller }

    it { should assign_to(:contents).with_kind_of(Array) }
  end

  describe "GET show" do
    before do
      @collection = FactoryGirl.create(:collection_with_contents)
      @content = @collection.contents.first
      get :show, { id: @content, collection_id: @collection }
    end
    subject { controller }

    it { should assign_to(:content).with(@content) }
  end

  describe "GET new" do
    before do
      @collection = FactoryGirl.create(:collection)
      get :new, { collection_id: @collection }
    end
    subject { controller }

    it { should assign_to(:content) }
  end

  describe "GET edit" do
    before do
      @collection = FactoryGirl.create(:collection_with_contents)
      @content = @collection.contents.first
      get :edit, { id: @content, collection_id: @collection }
    end
    subject { controller }

    it { should assign_to(:content).with(@content) }
  end

  describe "POST create" do
    context "with valid params" do
      before do
        @collection = FactoryGirl.create(:collection)
        @content_attributes = FactoryGirl.attributes_for(:content)
      end

      it "creates a new Content" do
        expect {
          post :create, { content: @content_attributes, collection_id: @collection }
        }.to change(Content, :count).by(1)
      end

      it "assigns a newly created content as @content" do
        post :create, { content: @content_attributes, collection_id: @collection }
        assigns(:content).should be_a(Content)
        assigns(:content).should be_persisted
      end

      it "redirects to the created content" do
        post :create, { content: @content_attributes, collection_id: @collection }
        response.should redirect_to(collection_content_path(@collection, Collection.last))
      end
    end

    context "with invalid params" do
      before do
        @collection = FactoryGirl.create(:collection)
        @invalid_content_attributes = FactoryGirl.attributes_for(:invalid_content)
        post :create, { content: @invalid_content_attributes, collection_id: @collection }
      end

      it "assigns a newly created but unsaved content as @content" do
        assigns(:content).should be_a_new(Content)
      end

      it { should render_template :new }
    end
  end

  describe "PUT update" do
    before do
      @collection = FactoryGirl.create(:collection) do |collection|
        collection.contents.create(
          attributes_for(
            :content,
            title: "Lorem ipsum dolor sit amet",
            body: "A pretty neat body",
            location: "http://good-example.com"
          )
        )
      end
      @content = @collection.contents.first
    end

    context "with valid params" do
      it "updates the requested content" do
        put :update, { id: @content, collection_id: @collection, content: FactoryGirl.attributes_for(:content) }
        assigns(:content).should eq(@content)
      end

      it "assigns the requested content as @content" do
        put :update, {
          id: @content,
          collection_id: @collection,
          content: FactoryGirl.attributes_for(
            :content,
            title: "Bacon ipsum dolor sit amet",
            body: "A very neat body",
            location: "http://good-test.com"
          )
        }
        @content.reload
        @content.title.should eq("Bacon ipsum dolor sit amet".titleize)
        @content.body.should eq("A very neat body")
        @content.location.should eq("http://good-test.com")
      end

      it "redirects to the content" do
        put :update, { id: @content, collection_id: @collection, content: FactoryGirl.attributes_for(:content) }
        response.should redirect_to(collection_content_path(@collection, @content))
      end
    end

    context "with invalid params" do
      it "assigns the content as @content" do
        put :update, { id: @content, collection_id: @collection, content: FactoryGirl.attributes_for(:invalid_content) }
        assigns(:content).should eq(@content)
      end

      it "does not assigns the requested content as @content" do
        put :update, {
          id: @content,
          collection_id: @collection,
          content: FactoryGirl.attributes_for(
            :invalid_content,
            title: "Bacon ipsum dolor sit amet",
            location: "http://bad-test.com"
          )
        }
        @content.reload
        @content.title.should_not eq("Bacon ipsum dolor sit amet")
        @content.body.should eq("A pretty neat body")
        @content.location.should eq("http://good-example.com")
      end

      it "re-renders the 'edit' template" do
        put :update, { id: @content, collection_id: @collection, content: FactoryGirl.attributes_for(:invalid_content) }
        response.should render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before do
      @collection = FactoryGirl.create(:collection) do |collection|
        collection.contents.create(attributes_for(:content))
      end
      @content = @collection.contents.first
    end

    it "destroys the requested content" do
      expect {
        delete :destroy, { id: @content, collection_id: @collection }
      }.to change(Content, :count).by(-1)
    end

    it "redirects to the contents list" do
      delete :destroy, { id: @content, collection_id: @collection }
      response.should redirect_to(collection_contents_path)
    end
  end

end
