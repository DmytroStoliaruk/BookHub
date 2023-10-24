class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true

  scope :ordered, -> { order(title: :asc) }
end
