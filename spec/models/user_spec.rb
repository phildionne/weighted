require 'spec_helper'

describe User do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.build(:user) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_user) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
  end

  describe :Validations do
  end

end
