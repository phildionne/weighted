# User
# @abstract @TODO
#
# @!attribute @TODO
#
class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
  :recoverable, :validatable, :omniauthable, :omniauth_providers => [:twitter]

  attr_accessible :email, :password, :password_confirmation, :username

  has_one :profile,      inverse_of: :user, dependent: :destroy
  has_one :subscription, inverse_of: :user, dependent: :destroy

  has_many :follows, foreign_key: 'user_id', dependent: :destroy
  has_many :followed_collections, through: :follows, source: :collection
  has_and_belongs_to_many :contents

  # :email, :password and :password_confirmation validations are ensured by devise
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, format: { with: /\A[\w]{1,20}\z/,
    message: "is authorized: letters A-Z, numbers 0-9, underscores, 1-20 characters." }

  validates_associated :profile, :subscription

  delegate :avatar, :first_name, :last_name, :name, to: :profile

  # Find or create a User based on Auth provider and uid
  #
  # @param auth @TODO
  def self.first_or_create_from_auth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.username = auth.info.nickname
      user.email = auth.info.email
      user.provider = auth.provider
      user.uid = auth.uid
    end
  end

  # Populates a new User from the session and trigger validations
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

  # In In Users/Registrations#new, don't require password when coming from OAuth provider
  def password_required?
    super && provider.blank?
  end

  # In Users/Registrations#update, only require current password if user signed up with password
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  # Returns either the User's name or username
  #
  # @return [String]
  def flexible_name
    name || username
  end

  # Make a user follow a collection
  #
  # @param collection [Collection]
  # @return [Boolean] Whether the user is not already following the collection
  def follow!(collection)
    begin
      follows.create!(collection: collection)
    rescue ActiveRecord::RecordInvalid
      return false
    end
  end

  # Make a user unfollow a collection
  #
  # @param collection [Collection]
  # @return [Boolean] Whether the user is already following the collection
  def unfollow!(collection)
    is_existing_record = following?(collection)
    if is_existing_record
      follows.find_by_collection_id(collection.id).destroy
    else
      return false
    end
  end

  # Wether a user is following a collection
  #
  # @param collection [Collection]
  # @return [Boolean] Whether the user is following the collection
  def following?(collection)
    is_existing_record = follows.find_by_collection_id(collection.id)
    !!is_existing_record
  end
end
