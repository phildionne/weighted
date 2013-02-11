require 'spec_helper'

describe "profiles/index" do
  before(:each) do
    assign(:profiles, [
      stub_model(Profile,
        :gravatar_email => "Gravatar Email",
        :first_name => "First Name",
        :last_name => "Last Name",
        :avatar => "Avatar"
      ),
      stub_model(Profile,
        :gravatar_email => "Gravatar Email",
        :first_name => "First Name",
        :last_name => "Last Name",
        :avatar => "Avatar"
      )
    ])
  end

  it "renders a list of profiles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Gravatar Email".to_s, :count => 2
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Avatar".to_s, :count => 2
  end
end
