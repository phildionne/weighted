require 'spec_helper'

describe Collection do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:collection) }
      specify { should be_valid }

      subject { FactoryGirl.create(:collection_with_contents) }
      specify { should be_valid }

      subject { FactoryGirl.create(:collection_with_sources) }
      specify { should be_valid }

      subject { FactoryGirl.create(:collection_with_sources_and_contents) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_collection) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should have_many(:contents) }
    it { should have_many(:follows).dependent(:destroy) }
    it { should have_many(:reverse_follows).dependent(:destroy) }
    it { should have_and_belong_to_many(:sources) }
  end

  describe :Validations do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:subject) }
    # it { should validate_uniqueness_of(:description) }
    it { should validate_uniqueness_of(:subject) }
    it { should ensure_length_of(:subject).is_at_least(3).is_at_most(255) }

    it { should allow_mass_assignment_of(:description) }
    it { should allow_mass_assignment_of(:subject) }
  end

  describe :Callbacks do
    let(:collection) { FactoryGirl.build(:collection, subject: 'sriracha') }

    describe :titleize_subject do
      it "titleizes the subject attribute" do
        collection.save
        collection.subject.should eq('Sriracha')
      end
    end
  end

  describe :ClassMethods do

    describe :with_data do
      let(:collection) { FactoryGirl.create(:collection) }

      it "finds the record with an existing key" do
        collection.data[:foo] = :bar
        collection.save

        Collection.with_data(:foo, :bar).should include(collection)
      end

      it "doesnt find the record without an existing key" do
        Collection.with_data(:foo, :bar).should_not include(collection)
      end

      it "returns an ActiveRecord::Relation" do
        Collection.with_data(:foo, :bar).should be_a(ActiveRecord::Relation)
      end
    end
  end

  describe :InstanceMethods do
    let(:user) { FactoryGirl.create(:user) }

    describe "Follows" do
      let(:collection) { FactoryGirl.create(:collection) }

      it { should respond_to(:follows) }
      it { should respond_to(:followers) }
      it { should respond_to(:reverse_follows) }
      it { should respond_to(:followed_by?) }

      describe :followers do
        it "returns a collection of user records" do
          user.follow!(collection)
          collection.followers.should include(user)
        end
      end

      describe :followed_by? do
        it "returns true when the collection is being followed by the user" do
          user.follow!(collection)
          collection.followed_by?(user).should be_true
        end

        it "returns false when the collection is not being followed by the user" do
          collection.followed_by?(user).should be_false
        end
      end

    end
  end
end
