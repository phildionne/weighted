# Collection
# @abstract @TODO
#
# @!attribute @TODO
#
# @note Follows: `user` and `collection` are valid and persisted records
#
class Collection < ActiveRecord::Base
  attr_accessible :description, :subject

  has_many :contents
  has_many :follows, dependent: :destroy
  has_and_belongs_to_many :sources

  validates :description, :subject,   presence: true
  validates :description, :subject,   uniqueness: true
  validates :subject,                 length: { minimum: 3, maximum: 255 }

  before_save { self.subject = self.subject.titleize }

  # @return [Array] A collection of [User] records
  def followers
    user_ids = Follow.where(collection_id: self.id).pluck(:user_id)
    User.find(user_ids)
  end

  # @param [User]
  # @return [Boolean] Whether the collection is being followed by the user
  def followed_by?(user)
    Follow.where(collection_id: self.id, user_id: user.id).exists?
  end

  # @return [Fixnum] The number of users following the collection
  def followers_count
    Follow.where(collection_id: self.id).count
  end
end
