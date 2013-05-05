require 'spec_helper'

describe Subscription do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:subscription) }
      specify { should be_valid }
    end

    context "Valid factory" do
      subject { FactoryGirl.create(:active_subscription) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_subscription) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should belong_to(:user) }
  end

  describe :Validations do
    it { should validate_presence_of(:user) }
  end

  describe :Callbacks do
    let(:stripe) { double(Stripe::Customer) }

    # @TODO
    describe :create_stripe_customer do
      before { @user = FactoryGirl.build(:user) }

      it "makes a request to create a stripe customer" do
        stripe.should_receive(:create)

        @user.save!
      end

      # it "creates the right stripe customer" do
      # end
    end

    # @TODO
    describe :destroy_stripe_customer do
      before { @user = FactoryGirl.create(:user) }

      it "makes a request to destroy a stripe customer" do
        stripe.should_receive(:retrieve)

        @user.destroy
      end

      # it "destroys the right stripe customer" do
      # end
    end
  end

  describe :ClassMethods do
  end

  describe :InstanceMethods do
  end
end
