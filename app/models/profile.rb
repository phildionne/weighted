class Profile < ActiveRecord::Base
  attr_accessible :avatar, :first_name, :gravatar_email, :last_name

  validates_length_of :first_name, :maximum => 64, :allow_blank => true, :on => :update
  validates_length_of :last_name, :maximum => 64, :allow_blank => true, :on => :update

  # FIXME: Find a better regex to validate email
  validates_format_of :gravatar_email, :with => /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/,
    :allow_blank => true,
    :on => :update

  belongs_to :user
end
