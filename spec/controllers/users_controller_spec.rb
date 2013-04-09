require 'spec_helper'

describe UsersController do

  describe "GET show" do
    before do
      @user = FactoryGirl.create(:user)
      get :show, { id: @user }
    end

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :show
    end
  end

end
