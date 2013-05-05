# VCR configuration
# see https://www.relishapp.com/vcr/vcr/docs/getting-started

require 'vcr'

VCR.configure do |c|
  # c.default_cassette_options = { :re_record_interval => 86400 }
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
end
