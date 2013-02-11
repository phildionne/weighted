class Profile < ActiveRecord::Base
  attr_accessible :avatar, :first_name, :gravatar_email, :last_name
end
