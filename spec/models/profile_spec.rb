require 'spec_helper'

describe Profile do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.build(:profile) }
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
    it { should ensure_length_of(:name).is_at_least(3).is_at_most(128) }
    it { should ensure_length_of(:first_name).is_at_least(3).is_at_most(64) }
    it { should ensure_length_of(:first_name).is_at_least(3).is_at_most(64) }

    it { should allow_mass_assignment_of(:first_name) }
    it { should allow_mass_assignment_of(:gravatar_email) }
    it { should allow_mass_assignment_of(:last_name) }
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:provider_avatar) }

    it { should allow_value("email@example.com").for(:gravatar_email) }
    it { should_not allow_value("not an email").for(:gravatar_email) }
  end

end
