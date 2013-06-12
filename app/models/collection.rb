##
# Collection
# @abstract @TODO
#
# @!attribute @TODO
#
class Collection < ActiveRecord::Base
  serialize :data, ActiveRecord::Coders::Hstore

  attr_accessible :description, :subject

  has_many :follows, dependent: :destroy
  has_many :reverse_follows, foreign_key: 'collection_id', class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :reverse_follows, source: :user
  has_and_belongs_to_many :sources
  has_many :contents, through: :sources

  validates :description, :subject, presence: true
  validates :description, :subject, uniqueness: true
  validates :subject,               length: { minimum: 3, maximum: 255 }

  before_save :titleize_subject

  # Find all records where data attribute contains the passed key and value
  #
  # @note Uses database index
  # @param key [Symbol, String]
  # @param value [String]
  # @return [ActiveRecord::Relation]
  def self.with_data(key, value)
    where("data @> hstore(:key, :value)", key: key, value: value)
  end

  # @param user [User]
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
