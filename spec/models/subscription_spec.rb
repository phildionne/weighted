require 'spec_helper'

describe Subscription do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:subscription) }
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

    # @TODO
    describe :create_stripe_customer do
      before { @user = FactoryGirl.build(:user) }

      it "makes a request to create a stripe customer" do
        Stripe::Customer.should_receive(:create)
        @user.run_callbacks(:save)
      end

      it "raises on failure" do
        WebMock.disable_net_connect!
        expect { @user.save! }.to raise_error
      end
    end

    # @TODO
    describe :destroy_stripe_customer do
      let(:user) { FactoryGirl.create(:user) }

      it "makes a request to destroy a stripe customer" do
        Stripe::Customer.should_receive(:retrieve)
        user.run_callbacks(:destroy)
      end

      it "rollsback on failure" do
        WebMock.disable_net_connect!
        user.run_callbacks(:destroy)
        user.should be_persisted
      end
    end
  end

  describe :ClassMethods do
  end

  describe :InstanceMethods do
    it { should respond_to(:trialing?) }
    it { should respond_to(:active?) }
    it { should respond_to(:past_due?) }
    it { should respond_to(:canceled?) }
    it { should respond_to(:unpaid?) }
  end
end
