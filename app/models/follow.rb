class Follow < ActiveRecord::Base
  attr_accessible :user, :collection

  belongs_to :user
  belongs_to :collection

  validates :user, :collection, presence: true
end
