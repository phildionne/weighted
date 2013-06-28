require 'spec_helper'

describe Profile do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:profile) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_profile) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should belong_to(:user) }
  end

  describe :Validations do
    it { should validate_presence_of(:user) }
    it { should ensure_length_of(:first_name).is_at_least(3).is_at_most(64) }
    it { should ensure_length_of(:last_name).is_at_least(3).is_at_most(64) }

    it { should allow_mass_assignment_of(:first_name) }
    it { should allow_mass_assignment_of(:gravatar_email) }
    it { should allow_mass_assignment_of(:last_name) }
    it { should allow_mass_assignment_of(:provider_avatar) }

    it { should allow_value("email@example.com").for(:gravatar_email) }
    it { should_not allow_value("not an email").for(:gravatar_email) }
  end

  describe :InstanceMethods do
    describe :full_name do
      let(:profile) { FactoryGirl.create(:profile, first_name: "Foo", last_name: "Bar") }

      it "includes first_name and last_name" do
        profile.full_name.should eq("Foo Bar")
      end
    end

    describe :avatar do
      let(:profile) { FactoryGirl.create(:profile, gravatar_email: nil, provider_avatar: nil) }

      it "returns the gravatar_avatar when gravatar_email is specified" do
        profile.gravatar_email = "test@example.com"
        profile.avatar.should match(Digest::MD5.hexdigest('test@example.com'))
      end

      it "returns the provider_avatar when gravatar_email is not specified" do
        profile.provider_avatar = "http://www.example.com/provider_avatar_test.png"
        profile.avatar.should eq("http://www.example.com/provider_avatar_test.png")
      end

      it "returns the default avatar when gravatar_email and provider_avatar are not specified" do
        profile.avatar.should eq(Profile::DEFAULT_AVATAR)
      end
    end
  end

end
