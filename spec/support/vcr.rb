# VCR configuration
# see https://www.relishapp.com/vcr/vcr/docs/getting-started

require 'vcr'

VCR.configure do |vcr|

  options = {
    record: :once,
    re_record_interval: 1.day,
    match_requests_on: [:method, :uri, :body]
    # allow_playback_repeats: true
  }

  vcr.default_cassette_options = options
  vcr.cassette_library_dir = 'spec/fixtures/cassettes'
  vcr.hook_into :webmock
  vcr.configure_rspec_metadata!

  # vcr.before_playback do |interaction|
  #   interaction.request.body.gsub!(/foo/, 'bar')
  #   interaction.response.body.gsub!(/foo/, 'bar')
  # end

  vcr.around_http_request do |request|

    if URI(request.uri).query == 'email=tester%40example.com&plan=default'
      # @TODO FUCKING FIND HOW TO DO THIS SHIT
    end

    if request.uri =~ /api.stripe.com/
      uri = URI(request.uri)
      id = request.body ? request.body.hash : ""
      name = "#{[uri.host, uri.path, request.method, id].join('/')}"

      VCR.use_cassette(name, &request)
    end

  end
end

# RSpec.configure do |config|
#   config.around do |example|

#     VCR.use_cassette(example.metadata[:description_args]) do |cassette|
#       example.run
#     end
#   end
# end
