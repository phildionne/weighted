require "spec_helper"

describe UsersController do
  describe "routing" do

    it "routes to #show" do
      get("/users/1").should route_to("users#show", :id => "1")
    end

    it "routes to #followed_collections" do
      get("/users/1/followed_collections").should route_to("users#followed_collections", :id => "1")
    end

  end
end
