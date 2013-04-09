class Profile < ActiveRecord::Base
  attr_accessible :first_name, :gravatar_email, :last_name, :provider_avatar

  DEFAULT_AVATAR = 'assets/default_avatar.png'

  validates :user,          presence: true
  validates :first_name,    length: { minimum: 3, maximum: 64, allow_blank: true }
  validates :last_name,     length: { minimum: 3, maximum: 64, allow_blank: true }

  # FIXME: Find a better regex to validate email
  validates :gravatar_email, format: { with: /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/,
    allow_blank: true }

  belongs_to :user

  def name
    "#{first_name} #{last_name}"
  end

  def avatar
    if self.gravatar_email.present?
      self.gravatar_avatar
    elsif self.provider_avatar.present?
      self.provider_avatar
    else
      DEFAULT_AVATAR
    end
  end

  def update_attributes_from_auth(auth={})
    if auth.has_key?(:info)
      auth = auth.info
    end

    self.update_attributes({
      first_name: auth.first_name,
      last_name: auth.last_name,
      provider_avatar: auth.image
      })
  end


  protected

  def gravatar_avatar
    "https://gravatar.com/avatar/#{Digest::MD5.hexdigest(self.gravatar_email.downcase)}.png?size=70"
  end
end
