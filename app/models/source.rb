##
# Source
# @abstract @TODO
#
# @!attribute @TODO
#
class Source < ActiveRecord::Base
  attr_accessible :location

  has_and_belongs_to_many :collections
  has_many :contents

  validates :location, url: true, presence: true
end
