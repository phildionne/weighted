FactoryGirl.define do
  factory :feed, parent: :collection do
    # @TODO Use a real feed url
    feed_url Faker::Internet.url
  end

  factory :invalid_feed, parent: :feed do
    feed_url nil
  end
end
