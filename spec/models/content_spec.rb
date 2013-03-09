require 'spec_helper'

describe Content do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.build(:content) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_content) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    pending
  end

  describe :Validations do
    pending
  end

end
