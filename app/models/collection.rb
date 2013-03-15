class Collection < ActiveRecord::Base
  attr_accessible :description, :subject

  has_many :contents

  validates_presence_of     :description, :subject
  validates_uniqueness_of   :description, :subject
  validates_length_of       :subject, minimum: 3, maximum: 255

  before_save { self.subject = self.subject.titleize }
end
