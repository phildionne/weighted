require 'spec_helper'

describe Content do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:content) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_content) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should have_and_belong_to_many(:users) }
    it { should belong_to(:source) }
    it { should have_many(:collections).through(:source) }
  end

  describe :Validations do
    it { should validate_presence_of(:source) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:title) }
    # it { should validate_uniqueness_of(:location) }
    it { should validate_uniqueness_of(:title) }
    it { should ensure_length_of(:title).is_at_least(3).is_at_most(255) }

    it { should allow_mass_assignment_of(:body) }
    it { should allow_mass_assignment_of(:location) }
    it { should allow_mass_assignment_of(:title) }
  end

  describe :Callbacks do
    let(:content) { FactoryGirl.build(:content, title: 'sriracha') }

    describe :titleize_title do
      it "titleizes record's title attribute" do
        content.save
        content.title.should eq('Sriracha')
      end
    end
  end

end
