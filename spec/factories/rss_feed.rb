FactoryGirl.define do
  factory :rss_feed, parent: :source do
    # @TODO Use a real rss_feed url
    location Faker::Internet.url
  end

  factory :invalid_rss_feed, parent: :rss_feed do
    location nil
  end
end
