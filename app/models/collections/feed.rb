##
# Feed
# @abstract @TODO
#
# @!attribute @TODO
#
class Feed < Collection
  hstore_accessor :data, :feed_url

  attr_accessible :feed_url

  validates :feed_url, url: true, rss_feed: true, presence: true
end
