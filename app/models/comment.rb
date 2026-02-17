class Comment < ApplicationRecord
  belongs_to :blog
  validates :body, presence: true
  validate :blog_must_be_published

  private

  def blog_must_be_published
    unless blog&.published?
      errors.add(:base, "Cannot comment on an unpublished blog")
    end
  end
end
