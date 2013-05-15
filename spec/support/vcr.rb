# VCR configuration
# see https://www.relishapp.com/vcr/vcr/docs/getting-started

require 'vcr'

VCR.configure do |vcr|
  vcr.default_cassette_options = { record: :once, re_record_interval: 1.day }
  vcr.cassette_library_dir = 'spec/fixtures/cassettes'
  vcr.hook_into :webmock
  vcr.configure_rspec_metadata!

  vcr.around_http_request do |request|

    if request.uri =~ /api.stripe.com/
      uri = URI(request.uri)
      name = "#{[uri.host, uri.path, request.method].join('/')}"
      VCR.use_cassette(name, &request)

    elsif request.uri =~ /twitter.com/
      VCR.use_cassette('twitter', &request)
    else
    end

  end
end
