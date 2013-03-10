require 'spec_helper'

describe User do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.build(:user) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_user) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should have_one(:profile).dependent(:destroy) }
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

end
