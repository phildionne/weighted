require 'spec_helper'

describe Users::OmniauthCallbacksController do
  include Devise::TestHelpers

  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
  end

  describe :all do
    it "updates the user's profile with auth provider informations" do
      pending
    end
  end
end
