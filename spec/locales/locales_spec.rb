require 'spec_helper'

Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')].each do |locale_file|
  describe "a locale file" do
    it_behaves_like 'a valid locale file', locale_file
  end
end
