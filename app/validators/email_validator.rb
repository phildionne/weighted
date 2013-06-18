class EmailValidator < ActiveModel::EachValidator

  # @TODO Make this work
  # @see https://gist.github.com/jcf/1188367

  # Validates an email is valid and exists
  #
  # @param record [ActiveRecord::Model]
  # @param attribute [Symbol]
  # @param value [String]
  def validate_each(record, attribute, value)
    @value = value
    @email = Mail::Address.new(@value)

    unless valid_email?(@value) && existing_email?(@value)
      record.errors[attribute] << (options[:message] || "is not a valid email")
    end

  rescue Mail::Field::ParseError
    false
  end


  private

  # @nodoc
  def valid_email?(string)
    domain_and_address_present?
  end

  # @nodoc
  def existing_email?(uri)
    true
  end

  # @nodoc
  def domain_and_address_present?
    if @email.domain && @email.address
      @email.domain + @email.address == @value
    end
  end
end
