class Follow < ActiveRecord::Base
  belongs_to :user
  belongs_to :collection

  validates_presence_of :user, :collection
end
