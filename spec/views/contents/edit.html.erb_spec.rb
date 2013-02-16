require 'spec_helper'

describe "contents/edit" do
  before(:each) do
    @content = assign(:content, stub_model(Content,
      :title => "MyString",
      :body => "MyText",
      :source => "MyString"
    ))
  end

  it "renders the edit content form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => contents_path(@content), :method => "post" do
      assert_select "input#content_title", :name => "content[title]"
      assert_select "textarea#content_body", :name => "content[body]"
      assert_select "input#content_source", :name => "content[source]"
    end
  end
end
