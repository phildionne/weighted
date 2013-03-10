require 'spec_helper'

describe UsersController do

  describe "GET show" do
    before do
      @user = FactoryGirl.create(:user)
      get :show, { id: @user }
    end
    subject { controller }

    it { should assign_to(:user).with(@user) }
  end

end
