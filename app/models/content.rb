class Content < ActiveRecord::Base
  attr_accessible :body, :source, :title

  belongs_to :collection

  validates_presence_of     :collection
  validates_presence_of     :body, :source, :title
  validates_uniqueness_of   :source, :title
  validates_length_of       :title, :maximum => 255, :allow_blank => false, :too_long => 'less than 255 characters'

  before_save { self.title = self.title.titleize }
end
