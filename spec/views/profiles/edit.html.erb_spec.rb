require 'spec_helper'

describe "profiles/edit" do
  before(:each) do
    @profile = assign(:profile, FactoryGirl.create(:profile))
  end

  it "renders the edit profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => profiles_path(@profile), :method => "post" do
      assert_select "input#profile_gravatar_email", :name => "profile[gravatar_email]"
      assert_select "input#profile_first_name", :name => "profile[first_name]"
      assert_select "input#profile_last_name", :name => "profile[last_name]"
      assert_select "input#profile_avatar", :name => "profile[avatar]"
    end
  end
end
