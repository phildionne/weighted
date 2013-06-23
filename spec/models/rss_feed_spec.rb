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

  describe :Associations do
  end

  describe :Validations do
    it { should validate_presence_of(:location) }
    it { should allow_mass_assignment_of(:location) }
  end

  describe :Callbacks do
  end

  describe :InstanceMethods do
  end
end
