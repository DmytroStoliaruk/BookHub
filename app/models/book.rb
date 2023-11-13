class Book < ApplicationRecord
  has_one_attached :cover
  has_one_attached :content

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true

  scope :ordered, -> { order("title") }
  update_index("books") { self }
end
