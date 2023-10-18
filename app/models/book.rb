# frozen_string_literal: true

class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true

  scope :ordered, -> { order(title: :asc) }
end
