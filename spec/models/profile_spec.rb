require 'spec_helper'

describe Profile do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.build(:profile) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_profile) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
  end

  describe :Validations do
  end

end
