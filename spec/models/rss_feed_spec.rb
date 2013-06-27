require 'spec_helper'

describe RssFeed do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:rss_feed) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_rss_feed) }
      specify { should_not be_valid }
    end
  end

end
