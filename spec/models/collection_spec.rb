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
    it { should have_many(:contents) }
  end

  describe :Validations do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:subject) }
    it { should validate_uniqueness_of(:description) }
    it { should validate_uniqueness_of(:subject) }
    it { should ensure_length_of(:subject).is_at_least(3).is_at_most(255) }

    it { should allow_mass_assignment_of(:description) }
    it { should allow_mass_assignment_of(:subject) }
  end

end
