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
end
