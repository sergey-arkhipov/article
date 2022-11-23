class Article < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  extend Pagy::ElasticsearchRails

  settings analysis: {
    filter: {
      russian_stop: {
        type: 'stop',
        stopwords: '_russian_'
      },
      russian_keywords: {
        type: 'keyword_marker',
        keywords: ['пример']
      },
      russian_stemmer: {
        type: 'stemmer',
        language: 'russian'
      },
      substring: {
        type: 'nGram',
        min_gram: 2,
        max_gram: 50
      }

    },
    analyzer: {
      rebuilt_russian: {
        tokenizer: 'standard',
        filter: %w[
          lowercase
          russian_stop
          russian_keywords
          russian_stemmer
          substring
        ]
      }
    }
  } do
    mappings dynamic: false do
      indexes :author, type: :text
      indexes :title, type: :text, analyzer: :rebuilt_russian
    end
  end
end
