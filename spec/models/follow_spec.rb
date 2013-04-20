require 'spec_helper'

describe Follow do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:follow) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_follow) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should belong_to(:user) }
    it { should belong_to(:collection) }
  end

  describe :Validations do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:collection) }
    # it { should validate_uniqueness_of(:user_id)
    #   .scoped_to(:user_id, :collection_id)
    #   .with_message(/already following/) }
  end

  describe :ClassMethods do
  end

  describe :InstanceMethods do
    it { should respond_to(:user) }
    it { should respond_to(:collection) }
  end

end
