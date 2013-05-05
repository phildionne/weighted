require 'spec_helper'

describe UserObserver do

  let(:user) { FactoryGirl.build(:user) }

  describe :after_create do
    it "creates a profile" do
      expect { user.save! }.to change(Profile, :count).by(1)
    end

    it "creates a subscription" do
      expect { user.save! }.to change(Subscription, :count).by(1)
    end
  end

end
