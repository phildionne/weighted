class Profile < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :gravatar_email, :provider_avatar

  DEFAULT_AVATAR = 'assets/default_avatar.png'

  validates :user,          presence: true
  validates :first_name,    length: { minimum: 3, maximum: 64, allow_blank: true }
  validates :last_name,     length: { minimum: 3, maximum: 64, allow_blank: true }

  # FIXME: Find a better regex to validate email
  validates :gravatar_email, format: {
    with: /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/,
    allow_blank: true }

  belongs_to :user

  def name
    "#{first_name} #{last_name}" if first_name && last_name
  end

  # @return [String]
  def avatar
    gravatar_avatar || provider_avatar || DEFAULT_AVATAR
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

  private

    def gravatar_avatar
      self.gravatar_email ? "https://gravatar.com/avatar/#{Digest::MD5.hexdigest(self.gravatar_email.downcase)}.png?size=70" : nil
    end
end
