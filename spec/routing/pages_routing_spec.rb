require "spec_helper"

describe HighVoltage::PagesController do
  describe "routing" do

    it "routes to #about" do
      get("pages/about").should route_to("high_voltage/pages#show", id: 'about')
    end

    it "routes to #contact" do
      get("pages/contact").should route_to("high_voltage/pages#show", id: 'contact')
    end

  end
end
