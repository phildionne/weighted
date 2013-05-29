# Collection
# @abstract @TODO
#
# @!attribute @TODO
#
class Collection < ActiveRecord::Base
  attr_accessible :description, :subject

  has_many :contents
  has_many :follows, dependent: :destroy
  has_many :reverse_follows, foreign_key: 'collection_id', class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :reverse_follows, source: :user
  has_and_belongs_to_many :sources

  validates :description, :subject, presence: true
  validates :description, :subject, uniqueness: true
  validates :subject,               length: { minimum: 3, maximum: 255 }

  before_save :titleize_subject

  # @param [User]
  # @return [Boolean] Whether the collection is being followed by the user
  def followed_by?(user)
    is_existing_record = follows.find_by_user_id(user.id)
    !!is_existing_record
  end

  private

  def titleize_subject
    self.subject = self.subject.titleize
  end

end
