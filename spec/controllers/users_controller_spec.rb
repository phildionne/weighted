require 'spec_helper'

describe UsersController do

  describe "GET show" do
    it "assigns the requested user as @user" do
      @user = FactoryGirl.create(:user)

      get :show, { id: @user }
      assigns(:user).should eq(@user)
    end
  end

end
