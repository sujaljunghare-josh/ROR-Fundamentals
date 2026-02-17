class Blog < ApplicationRecord
scope :published, -> { where(published: true) }

validates :title, presence: true
has_many :comments
end
