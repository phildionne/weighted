##
# Feed
# @abstract @TODO
#
# @!attribute @TODO
#
class Feed < Collection
  hstore_accessor :data, :feed_url

  attr_accessible :feed_url

  validates :feed_url, presence: true

  after_initialize :assign_uuid
  after_create     :create_feed_subscription
  after_destroy    :destroy_feed_subscription

  private

  def assign_uuid
    # UUID
  end

  # Creates the associated feed subscription on the 3rd party service
  #
  # @return [Boolean]
  def create_feed_subscription
    Weighted::Application::Superfeedr.subscribe(feed_url)
  end

  # Destroys the associated feed subscription on the 3rd party service
  #
  # @return [Boolean]
  def destroy_feed_subscription
    Weighted::Application::Superfeedr.unsubscribe(feed_url)
  end
end
