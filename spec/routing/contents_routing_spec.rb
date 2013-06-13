require "spec_helper"

describe ContentsController do
  describe "routing" do

    it "routes to #index" do
      get("/collections/:collection_id/contents").should route_to("contents#index", :collection_id => ":collection_id")
    end

    it "routes to #show" do
      get("/collections/:collection_id/contents/1").should route_to("contents#show", :collection_id => ":collection_id", :id => "1")
    end

    it "routes to #new" do
      get("/sources/:source_id/contents/new").should route_to("contents#new", :source_id => ":source_id")
    end

    it "routes to #create" do
      post("/sources/:source_id/contents").should route_to("contents#create", :source_id => ":source_id")
    end

    it "routes to #destroy" do
      delete("/sources/:source_id/contents/1").should route_to("contents#destroy", :source_id => ":source_id", :id => "1")
    end

  end
end
