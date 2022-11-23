class Article < ApplicationRecord
  include Searchable
  extend Pagy::ElasticsearchRails
  after_initialize :default_values

  settings do
    mappings dynamic: false do
      indexes :title, type: :text, analyzer: :russian
    end
  end

  private

  def default_values
    return unless new_record?

    self.changed_on = DateTime.current
  end
end
