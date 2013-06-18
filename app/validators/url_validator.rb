require 'addressable/uri'

class UrlValidator < ActiveModel::EachValidator

  # Validates a Url is valid and exists
  #
  # @param record [ActiveRecord::Model]
  # @param attribute [Symbol]
  # @param value [String]
  def validate_each(record, attribute, value)
    unless valid_uri?(value) && existing_uri?(value)
      record.errors[attribute] << (options[:message] || "is not a valid URL")
    end
  end


  private

  # @nodoc
  def valid_uri?(string)
    begin
      Addressable::URI.parse(string)
    rescue Addressable::URI::InvalidURIError
      false
    end
  end

  # @nodoc
  def existing_uri?(uri)
    uri = Addressable::URI.parse(uri).normalize
    Net::HTTP.new(uri.host).request_head(uri.path).code.to_i.in? 200..399
  rescue StandardError
    false
  end
end
