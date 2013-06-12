class Content < ActiveRecord::Base
  attr_accessible :body, :location, :title

  has_and_belongs_to_many :users

  belongs_to :source
  has_many :collections, through: :source

  validates :source,                  presence: true
  validates :body, :location, :title, presence: true
  validates :location, :title,        uniqueness: true
  validates :title,                   length: { minimum: 3, maximum: 255, allow_blank: false }

  before_save :titleize_title
  before_save :sanitize_body

  private

  def titleize_title
    self.title = self.title.titleize
  end

  # Sanitizes html content
  #
  # @note Allows a variety of markup including formatting tags, links, lists and tables.
  # @note Images are limited to HTTP and HTTPS, links are limited to FTP, HTTP, HTTPS, and mailto protocols.
  # @see Full configuration here https://github.com/rgrove/sanitize/blob/master/lib/sanitize/config/relaxed.rb
  def sanitize_body
    # TODO: Remove from the output the following node elements: data-*, id, class, onmouseout (and others), trackbacks, comment form
    # TODO: Handle code blocks and syntax highlighting
    Sanitize.clean(body, Sanitize::Config::RELAXED)
  end
end
