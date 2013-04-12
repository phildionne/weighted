# Omniauth configuration
# see https://github.com/intridea/omniauth/wiki/Integration-Testing

# Turn on "test mode" for OmniAuth
OmniAuth.config.test_mode = true

# Create a default auth hash
OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
  :provider => 'twitter',
  :uid => '12345',
  :info => {
    "nickname" => "Tester",
    "name" => "Tester",
    "location" => "TestVille",
    "image" => "http://a0.twimg.com/profile_images/test.jpeg",
    "description" => "Test description",
    "urls" => {
      "Website" => "http://test.com/",
      "Twitter" => "http://twitter.com/test"
    }
  }
})
