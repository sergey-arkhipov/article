class Article < ApplicationRecord
  extend Pagy::ElasticsearchRails
  include Searchable
  has_many :texts, dependent: :destroy
  accepts_nested_attributes_for :texts, allow_destroy: true

  before_save :default_values
  after_save :callback_elastick

  settings do
    mappings dynamic: false do
      indexes :id, type: :integer
      indexes :title, type: :text, analyzer: :russian
    end
  end

  private

  def default_values
    return unless new_record?

    self.changed_on = DateTime.current
  end

  
end
