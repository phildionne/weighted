class Source < ActiveRecord::Base
  attr_accessible :uri

  has_and_belongs_to_many :collections

  validates_presence_of :uri
end
