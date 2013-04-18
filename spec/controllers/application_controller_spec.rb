require 'spec_helper'

describe ApplicationController do
  include Devise::TestHelpers

  around do |example|
    Rails.application.config.consider_all_requests_local = false
    example.run
    Rails.application.config.consider_all_requests_local = true
  end

  describe "assign_current_user" do
    pending
  end

  describe "load_collection" do
    pending
  end

  describe "#render_error" do
    pending
  end
end
