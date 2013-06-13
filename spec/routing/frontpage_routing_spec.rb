require "spec_helper"

describe FrontpageController do
  describe "routing" do

    it "routes to #show" do
      get("/").should route_to("frontpage#show")
    end

  end
end
