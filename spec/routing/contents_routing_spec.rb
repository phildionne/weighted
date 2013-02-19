require "spec_helper"

describe ContentsController do
  describe "routing" do

    it "routes to #index" do
      get("/collections/:collection_id/contents").should route_to("contents#index", :collection_id => ":collection_id")
    end

    it "routes to #new" do
      get("/collections/:collection_id/contents/new").should route_to("contents#new", :collection_id => ":collection_id")
    end

    it "routes to #show" do
      get("/collections/:collection_id/contents/1").should route_to("contents#show", :collection_id => ":collection_id", :id => "1")
    end

    it "routes to #edit" do
      get("/collections/:collection_id/contents/1/edit").should route_to("contents#edit", :collection_id => ":collection_id", :id => "1")
    end

    it "routes to #create" do
      post("/collections/:collection_id/contents").should route_to("contents#create", :collection_id => ":collection_id")
    end

    it "routes to #update" do
      put("/collections/:collection_id/contents/1").should route_to("contents#update", :collection_id => ":collection_id", :id => "1")
    end

    it "routes to #destroy" do
      delete("/collections/:collection_id/contents/1").should route_to("contents#destroy", :collection_id => ":collection_id", :id => "1")
    end

  end
end
