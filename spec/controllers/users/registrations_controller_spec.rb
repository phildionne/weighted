require 'spec_helper'

describe Users::RegistrationsController do
  include Devise::TestHelpers

  before { request.env["devise.mapping"] = Devise.mappings[:user] }

  describe "create" do

    describe "when a user signs up through a auth provider" do
      context "with valid credentials" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] }

        it "populates the user's profile with auth provider informations" do
          pending
        end
      end
    end

  end
end
