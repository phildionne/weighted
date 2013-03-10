class Collection < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :contents

  validates_presence_of     :description, :name
  validates_uniqueness_of   :description, :name
  validates_length_of       :name, minimum: 3, maximum: 255

  before_save { self.name = self.name.titleize }
end
