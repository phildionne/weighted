require 'spec_helper'

describe Source do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:source) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_source) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should have_and_belong_to_many(:collections) }
    it { should have_many(:contents) }
  end

  describe :Validations do
    it { should validate_presence_of(:location) }
    it { should allow_mass_assignment_of(:location) }
  end

end
