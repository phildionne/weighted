require 'spec_helper'

describe "users/new" do
  before(:each) do
    assign(:user, FactoryGirl.create(:user))
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path, :method => "post" do
      assert_select "input#user_username", :name => "user[username]"
    end
  end
end
