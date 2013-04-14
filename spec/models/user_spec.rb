require 'spec_helper'

describe User do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:user) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_user) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should have_one(:profile).dependent(:destroy) }
    it { should have_many(:follows).dependent(:destroy) }
  end

  describe :Validations do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }

    it { should allow_mass_assignment_of(:email) }
    it { should allow_mass_assignment_of(:password) }
    it { should allow_mass_assignment_of(:password_confirmation) }
    it { should allow_mass_assignment_of(:username) }

    it { should_not allow_value("User Name").for(:username) }
    it { should_not allow_value("email@example.com").for(:username) }
    it { should_not allow_value("user-name").for(:username) }
    it { should_not allow_value("veryveryverylongusername").for(:username) }
  end

  describe :InstanceMethods do
    before { @user = FactoryGirl.create(:user) }

    describe "#flexible_name" do
      it "returns the name when name is specified" do
        @user.profile.first_name = "Foo"
        @user.profile.last_name = "Bar"

        @user.flexible_name.should eq("Foo Bar")
      end

      it "returns the username when name is not specified" do
        @user.username = "Foobar"
        @user.profile.first_name = nil
        @user.profile.last_name = nil

        @user.flexible_name.should eq("Foobar")
      end
    end

    describe "Follows" do
      before { @collection = FactoryGirl.create(:collection) }

      describe "follow!" do
        it "adds the collection to the user's collections" do
          expect(@user.following).to eq([])
          @user.follow!(@collection)

          expect(@user.following).to eq([@collection])
        end

        it "returns true when the user does not follow the collection" do
          @user.follow!(@collection).should be(true)
          expect(@user.following).to eq([@collection])
        end

        it "returns false when the user follows the collection" do
          @user.follow!(@collection)
          @user.follow!(@collection).should be(false)
          expect(@user.following).to eq([@collection])
        end
      end

      describe "unfollow!" do
        it "removes the collection from the user's collections" do
          @user.follow!(@collection)

          @user.unfollow!(@collection)
          expect(@user.following).to eq([])
        end

        it "returns true when the user already follows the collection" do
          @user.follow!(@collection)
          @user.unfollow!(@collection).should be(true)
          expect(@user.following).to eq([])
        end

        it "returns false when the user does not already follow the collection" do
          @user.unfollow!(@collection).should be(false)
          expect(@user.following).to eq([])
        end
      end

      describe "following" do
        it "returns a collection of Collection records" do
          @user.follow!(@collection)
          expect(@user.following).to eq([@collection])
        end
      end

      describe "following?" do
        it "returns true when the user follows the collection" do
          @user.follow!(@collection)
          @user.following?(@collection).should be(true)
        end

        it "returns false when the user does not follow the collection" do
          @user.following?(@collection).should be(false)
        end
      end

      describe "following_count" do
        it "returns a Fixnum" do
          @user.follow!(@collection)
          expect(@user.following_count).to be_a(Fixnum)
        end

        it "returns 0 when the user does not follow any collections" do
          expect(@user.following_count).to eq(0)
        end
      end
    end
  end
end
