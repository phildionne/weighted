require 'spec_helper'

describe "profiles/show" do
  before(:each) do
    @profile = assign(:profile, stub_model(Profile,
      :gravatar_email => "Gravatar Email",
      :first_name => "First Name",
      :last_name => "Last Name",
      :avatar => "Avatar"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Gravatar Email/)
    rendered.should match(/First Name/)
    rendered.should match(/Last Name/)
    rendered.should match(/Avatar/)
  end
end
