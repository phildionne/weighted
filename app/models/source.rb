class Source < ActiveRecord::Base
  attr_accessible :uri

  has_and_belongs_to_many :collections

  validates :uri, presence: true
end
