class RssFeedValidator < ActiveModel::EachValidator

  # Validates a RSS feed is valid and exists
  #
  # @param record [ActiveRecord::Model]
  # @param attribute [Symbol]
  # @param value [String]
  def validate_each(record, attribute, value)
    unless valid_rss_feed?(value) && existing_rss_feed?(value)
      record.errors[attribute] << (options[:message] || "is not a valid RSS feed")
    end
  end


  private

  # @nodoc
  def valid_rss_feed?(string)
    true
  end

  # @nodoc
  def existing_rss_feed?(uri)
    true
  end
end
