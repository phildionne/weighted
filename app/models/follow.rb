##
# Follow
# @abstract @TODO
#
# @!attribute @TODO
#
class Follow < ActiveRecord::Base
  attr_accessible :user, :collection

  belongs_to :user
  belongs_to :collection

  validates :user, :collection, presence: true
  validates :user_id, uniqueness: {
    scope: :collection_id,
    message: "already following this collection."
  }
end
