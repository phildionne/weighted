class Profile < ActiveRecord::Base
  attr_accessible :avatar, :first_name, :gravatar_email, :last_name, :name, :provider_avatar

  validates_length_of :name, :maximum => 128, :allow_blank => true
  validates_length_of :first_name, :maximum => 64, :allow_blank => true
  validates_length_of :last_name, :maximum => 64, :allow_blank => true

  # FIXME: Find a better regex to validate email
  validates_format_of :gravatar_email, :with => /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/,
    :allow_blank => true

  belongs_to :user


  def update_attributes_from_auth(auth={})
    if auth.has_key?(:info)
      auth = auth.info
    end

    self.update_attributes({
      name: auth.name,
      first_name: auth.first_name,
      last_name: auth.last_name,
      provider_avatar: auth.image
      })
  end
end
