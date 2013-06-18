class EmailValidator < ActiveModel::EachValidator

  # Validates an email is valid
  #
  # @param record [ActiveRecord::Model]
  # @param attribute [Symbol]
  # @param value [String]
  def validate_each(record, attribute, value)
    unless valid_email?(value)
      record.errors[attribute] << (options[:message] || "is not a valid email")
    end
  end


  private

  # @nodoc
  def valid_email?(string)
    begin
      @email = Mail::Address.new(string)

      # cannot be a local address
      @email.address == string && @email.local != string

    rescue Mail::Field::ParseError
      false
    end
  end
end
