require 'spec_helper'

describe "contents/index" do
  before(:each) do
    assign(:contents, [
      stub_model(Content,
        :title => "Title",
        :body => "MyText",
        :source => "Source"
      ),
      stub_model(Content,
        :title => "Title",
        :body => "MyText",
        :source => "Source"
      )
    ])
  end

  it "renders a list of contents" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
  end
end
