module ElascticHelper
  class << self
    def create_elastic_index
      ActiveRecord::Base.descendants.each do |model|
        next unless model.respond_to?(:__elasticsearch__)

        begin
          model.__elasticsearch__.create_index!
          model.__elasticsearch__.refresh_index!
        rescue Elasticsearch::Transport::Transport::Errors::NotFound => e
          # This kills "Index does not exist" errors being written to console
          # by this: https://github.com/elastic/elasticsearch-rails/blob/738c63efacc167b6e8faae3b01a1a0135cfc8bbb/elasticsearch-model/lib/elasticsearch/model/indexing.rb#L268
        rescue StandardError => e
          warn "There was an error creating the elasticsearch index for #{model.name}: #{e.inspect}"
        end
      end
    end

    def drop_elastic_index
      ActiveRecord::Base.descendants.each do |model|
        next unless model.respond_to?(:__elasticsearch__)

        begin
          model.__elasticsearch__.delete_index!
        rescue Elasticsearch::Transport::Transport::Errors::NotFound => e
          # This kills "Index does not exist" errors being written to console
          # by this: https://github.com/elastic/elasticsearch-rails/blob/738c63efacc167b6e8faae3b01a1a0135cfc8bbb/elasticsearch-model/lib/elasticsearch/model/indexing.rb#L268
        rescue StandardError => e
          warn "There was an error removing the elasticsearch index for #{model.name}: #{e.inspect}"
        end
      end
    end
  end
end
