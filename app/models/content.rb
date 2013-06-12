class Content < ActiveRecord::Base
  attr_accessible :body, :location, :title

  belongs_to :collection
  has_and_belongs_to_many :users

  validates :collection,                presence: true
  validates :body, :location, :title,   presence: true
  validates :location, :title,          uniqueness: true
  validates :title,                     length: { minimum: 3, maximum: 255, allow_blank: false }

  before_save :titleize_title

  private

  def titleize_title
    self.title = self.title.titleize
  end

end
