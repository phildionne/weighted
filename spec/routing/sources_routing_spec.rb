require "spec_helper"

describe SourcesController do
  describe "routing" do

    it "routes to #index" do
      get("/collections/:collection_id/sources").should route_to("sources#index", :collection_id => ":collection_id")
    end

    it "routes to #show" do
      get("/collections/:collection_id/sources/1").should route_to("sources#show", :collection_id => ":collection_id", :id => "1")
    end

    it "routes to #new" do
      get("/sources/new").should route_to("sources#new")
    end

    it "routes to #edit" do
      get("/sources/1/edit").should route_to("sources#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sources").should route_to("sources#create")
    end

    it "routes to #update" do
      put("/sources/1").should route_to("sources#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sources/1").should route_to("sources#destroy", :id => "1")
    end

  end
end
