require 'spec_helper'

describe User do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:user) }
      specify { should be_valid }
    end

    context "Valid factory" do
      subject { FactoryGirl.create(:oauth_user) }
      specify { should be_valid }
    end

    context "Valid factory" do
      subject { FactoryGirl.create(:user_with_followed_collections) }
      specify { should be_valid }
    end

    context "Valid factory" do
      subject { FactoryGirl.create(:user_with_active_subscription) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_user) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should have_one(:profile).dependent(:destroy) }
    it { should have_one(:subscription).dependent(:destroy) }
    it { should have_many(:follows).dependent(:destroy) }
    it { should have_many(:followed_collections) }
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
    let(:user) { FactoryGirl.create(:user) }

    describe :flexible_name do
      it "returns the name when name is specified" do
        user.profile.first_name = "Foo"
        user.profile.last_name = "Bar"

        user.flexible_name.should eq("Foo Bar")
      end

      it "returns the username when name is not specified" do
        user.username = "Foobar"
        user.profile.first_name = nil
        user.profile.last_name = nil

        user.flexible_name.should eq("Foobar")
      end
    end

    describe "Follows" do
      let(:collection) { FactoryGirl.create(:collection) }

      it { should respond_to(:follows) }
      it { should respond_to(:followed_collections) }
      it { should respond_to(:follow!) }
      it { should respond_to(:unfollow!) }
      it { should respond_to(:following?) }

      describe :follow! do
        it "adds the collection to the user's collections" do
          user.followed_collections.should be_empty
          user.follow!(collection)

          user.followed_collections.should include(collection)
        end

        it "returns true when the user does not already follow the collection" do
          user.follow!(collection).should be_true
        end

        it "returns false when the user already follows the collection" do
          user.follow!(collection)
          user.follow!(collection).should be_false
        end
      end

      describe :unfollow! do
        it "removes the collection from the user's collections" do
          user.follow!(collection)
          user.followed_collections.should_not be_empty

          user.unfollow!(collection)
          user.followed_collections.should_not include(collection)
        end

        it "returns true when the user already follows the collection" do
          user.follow!(collection)
          user.unfollow!(collection).should be_true
        end

        it "returns false when the user does not already follows the collection" do
          user.unfollow!(collection).should be_false
        end
      end

      describe :followed_collections do
        it "returns a collection of Collection records" do
          user.follow!(collection)
          user.followed_collections.should include(collection)
        end
      end

      describe :following? do
        it "returns true when the user already follows the collection" do
          user.follow!(collection)
          user.following?(collection).should be_true
        end

        it "returns false when the user does not already follows the collection" do
          user.following?(collection).should be_false
        end
      end

    end
  end
end
