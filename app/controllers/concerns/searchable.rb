module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
  end

  def self.search(query)
    __elasticsearch__.search(
      query: {
        multi_match: {
          query:,
          fields: ['title']
        }
      }
    )
  end
end
