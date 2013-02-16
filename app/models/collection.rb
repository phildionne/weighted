class Collection < ActiveRecord::Base
  attr_accessible :description, :name

  validates_presence_of :description, :name
  validates_uniqueness_of :description, :name
  validates_length_of :name, :maximum => 255, :too_long => 'less than 255 characters'

  before_save { self.name = self.name.titleize }
end
