require 'spec_helper'

describe ApplicationController do
  around do |example|
    Rails.application.config.consider_all_requests_local = false
    example.run
    Rails.application.config.consider_all_requests_local = true
  end

  describe :load_collection do
    pending
  end

  describe :render_error do
    pending
  end
end
