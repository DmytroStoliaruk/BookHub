class Book < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_one_attached :cover
  has_one_attached :content

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true

  scope :ordered, -> { order("title") }

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title, type: 'text'
      indexes :author, type: 'text'
      indexes :description, type: 'text'
    end
  end

  def self.search(search_params)
    search_query = {
        query: {
        multi_match: {
          query: search_params,
          fields: ['title', 'author', 'description'],
          fuzziness: 'AUTO'
        }
      }
    }
    __elasticsearch__.search(search_query)
  end
end
