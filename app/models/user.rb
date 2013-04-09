# User
# @abstract @TODO
#
# @!attribute @TODO
#
# @note Follows: `user` and `collection` are valid and persisted records
#
class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
  :recoverable, :validatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :username

  has_one :profile, inverse_of: :user, dependent: :destroy
  has_many :follows, dependent: :destroy

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, format: { with: /\A[\w]{1,20}\z/,
    message: "is authorized: letters A-Z, numbers 0-9, underscores, 1-20 characters." }

  after_create { self.create_profile }

  delegate :avatar, :first_name, :last_name, :name, to: :profile

  def self.first_or_create_from_auth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.username = auth.info.nickname
      user.email = auth.info.email
      user.provider = auth.provider
      user.uid = auth.uid
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  # When creating User registration, don't require password when coming from Twitter
  def password_required?
    super && provider.blank?
  end

  # When updating User registration, only require current password if signed up with password
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def flexible_name
    name.blank? ? username : name
  end

  # Make a user follow a collection
  # After calling this method successfuly, `user` follows the `collection`
  # and `user.following?(collection)` returns true
  #
  # @param [Collection]
  # @return Whether the user is not already following the collection
  def follow!(collection)
    follow = Follow.where(user_id: self.id, collection_id: collection.id).first_or_initialize
    is_new_record = follow.new_record?
    follow.save! if is_new_record
    return is_new_record
  end

  # Make a user unfollow a collection
  # After calling this method successfuly, `user` does not follow the `collection`
  # and `user.following?(collection)` returns false
  #
  # @param [Collection]
  # @return Whether the user is already following the collection
  def unfollow!(collection)
    follow_id = Follow.where(user_id: self.id, collection_id: collection.id).pluck(:id)
    is_existing_record = Follow.destroy(follow_id) != []
    return is_existing_record
  end

  # @return [Array] A collection of [Collection] records
  def following
    collection_ids = Follow.where(user_id: self.id).pluck(:collection_id)
    Collection.find(collection_ids)
  end

  # @param [Collection]
  # @return [Boolean] Whether the user is following the collection
  def following?(collection)
    Follow.where(user_id: self.id, collection_id: collection.id).exists?
  end

  # @return [Fixnum] The number of collections the user is following
  def following_count
    Follow.where(user_id: self.id).count
  end
end
