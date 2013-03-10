require 'spec_helper'

describe HomeController do
  include Devise::TestHelpers

  describe "GET 'index'" do
    context "being signed in" do

      before do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end

      it "returns http success" do
        pending
      end
    end

    context "beign signed out" do
      it "returns http success" do
        pending
      end

      it "shows the frontpage template" do
        pending
      end
    end
  end

end
