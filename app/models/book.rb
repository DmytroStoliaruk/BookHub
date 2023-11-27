class Book < ApplicationRecord
  update_index("books") { self }

  has_one_attached :cover, dependent: :destroy
  has_one_attached :content, dependent: :destroy

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true

  scope :ordered, -> { order("title") }
end
