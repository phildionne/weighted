class Content < ActiveRecord::Base
  attr_accessible :body, :location, :title

  belongs_to :collection

  validates_presence_of     :collection
  validates_presence_of     :body, :location, :title
  validates_uniqueness_of   :location, :title
  validates_length_of       :title, minimum: 3, maximum: 255, allow_blank: false

  before_save { self.title = self.title.titleize }
end
