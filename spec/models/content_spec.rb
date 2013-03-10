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
    it { should belong_to(:collection) }
  end

  describe :Validations do
    it { should validate_presence_of(:collection) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:source) }
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:source) }
    it { should validate_uniqueness_of(:title) }
    it { should ensure_length_of(:title).is_at_least(3).is_at_most(255) }

    it { should allow_mass_assignment_of(:body) }
    it { should allow_mass_assignment_of(:source) }
    it { should allow_mass_assignment_of(:title) }
  end

end
