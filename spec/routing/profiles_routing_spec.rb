require "spec_helper"

describe Settings::ProfilesController do
  describe "routing" do

    it "routes to #show" do
      get("settings/profile").should route_to("settings/profiles#show")
    end

    it "routes to #update" do
      put("settings/profile").should route_to("settings/profiles#update")
    end

  end
end
