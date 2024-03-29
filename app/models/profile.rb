##
# Profile
# @abstract @TODO
#
# @!attribute @TODO
#
class Profile < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :gravatar_email, :provider_avatar

  DEFAULT_AVATAR = 'assets/default_avatar.png'

  validates :user,       presence: true
  validates :first_name, length: { minimum: 3, maximum: 64, allow_blank: true }
  validates :last_name,  length: { minimum: 3, maximum: 64, allow_blank: true }

  validates :gravatar_email, email: true, allow_blank: true

  belongs_to :user

  # @return [String]
  def full_name
    "#{first_name} #{last_name}" if first_name && last_name
  end

  # @return [String]
  def avatar
    gravatar_avatar || provider_avatar || DEFAULT_AVATAR
  end

  # Updates Profile attributes from Omiauth Auth hash
  # @param auth [Hash]
  def update_attributes_from_auth(auth)
    update_attributes({
      provider_avatar: auth.image
      })
  end

  private

  # @return [String, Nil] Gravatar url or nil
  def gravatar_avatar
    gravatar_email ? "https://gravatar.com/avatar/#{Digest::MD5.hexdigest(gravatar_email.downcase)}.png?size=70" : nil
  end

end
