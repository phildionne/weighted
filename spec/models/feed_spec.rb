require 'spec_helper'

describe Feed do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:feed) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_feed) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
  end

  describe :Validations do
    it { should validate_presence_of(:feed_url) }
    it { should validate_presence_of(:feed_uuid) }

    it { should allow_mass_assignment_of(:feed_url) }
  end

  describe :Callbacks do
    let(:feed) { FactoryGirl.build(:feed, subject: 'sriracha') }

    describe :assign_uuid do
      it "description" do

      end
    end

    describe :create_feed_subscription do
      it "description" do

      end
    end

    describe :destroy_feed_subscription do
      it "description" do

      end
    end
  end

  describe :InstanceMethods do
    let(:feed) { FactoryGirl.create(:feed) }
  end
end
