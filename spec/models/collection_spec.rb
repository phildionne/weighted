require 'spec_helper'

describe Collection do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.build(:collection) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_collection) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
  end

  describe :Validations do
  end

end
