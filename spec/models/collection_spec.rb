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
    it { should have_many(:follows).dependent(:destroy) }
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

  describe :InstanceMethods do
    before { @user = FactoryGirl.create(:user) }

    describe "Follows" do
      before { @collection = FactoryGirl.create(:collection) }

      describe "followers" do
        it "returns a collection of user records" do
          @user.follow!(@collection)
          expect(@collection.followers).to eq([@user])
        end
      end

      describe "followed_by?" do
        it "returns true when the collection is being followed by the user" do
          @user.follow!(@collection)
          @collection.followed_by?(@user).should be(true)
        end

        it "returns false when the collection is not being followed by the user" do
          @collection.followed_by?(@user).should be(false)
        end
      end

      describe "followers_count" do
        it "returns a Fixnum" do
          @user.follow!(@collection)
          expect(@collection.followers_count).to be_a(Fixnum)
        end

        it "returns 0 when the collection is not being followed by any user" do
          expect(@collection.followers_count).to eq(0)
        end
      end
    end
  end
end
