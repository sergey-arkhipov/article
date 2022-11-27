module Searchable
  extend ActiveSupport::Concern
  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
  end

  class_methods do
    def search(query, params = {})
      __elasticsearch__.search(
        query: {
          query_string: {
            query: query.to_s,
            fields: ['title']
          }
        },
        # from: 0,
        # size: 20,
        **params
      )
    end

    def gets_all
      __elasticsearch__.all
    end
  end
  # Instance methods. Can be unnecessary
  def callback_elastick
    Article.__elasticsearch__.create_index!
    Article.import
  end
end
