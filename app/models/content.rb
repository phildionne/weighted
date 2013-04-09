class Content < ActiveRecord::Base
  attr_accessible :body, :location, :title

  belongs_to :collection

  validates :collection,                presence: true
  validates :body, :location, :title,   presence: true
  validates :location, :title,          uniqueness: true
  validates :title,                     length: { minimum: 3, maximum: 255, allow_blank: false }

  before_save { self.title = self.title.titleize }
end
