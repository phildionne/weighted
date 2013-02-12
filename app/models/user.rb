class User < ActiveRecord::Base

  # :token_authenticatable, :confirmable, :rememberable
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
  :recoverable, :validatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :username

  has_one :profile, :inverse_of => :user, :dependent => :destroy

  validates_presence_of   :username
  validates_uniqueness_of :username
  validates_format_of     :username, :with => /\A[\w]{1,20}\z/, :message => "is authorized: letters A-Z, numbers 0-9, underscores, 1-20 characters."

  after_create { self.create_profile }

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
      new(session["devise.user_attributes"], :without_protection => true) do |user|
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
end
