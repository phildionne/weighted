class Source < ActiveRecord::Base
  attr_accessible :location

  has_and_belongs_to_many :collections
  has_many :contents

  validates :location, url_format: true, presence: true
end
