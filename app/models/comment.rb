class Comment < ApplicationRecord
  belongs_to :blog
  validates :body, presence: true
  validate :blog_must_be_published

  private

  def blog_must_be_published
    if blog.present? && !blog.published?
      errors.add(:base, "must be published before adding comments")
    end
  end
end
