class Article < ApplicationRecord
  extend Pagy::ElasticsearchRails
  include Searchable
  has_many :texts, dependent: :destroy
  accepts_nested_attributes_for :texts, allow_destroy: true
  validates :author, presence: true
  validates :title, presence: true
  before_save :default_values
  # Not necessary 
  # after_save :callback_elastick

  settings do
    mappings dynamic: false do
      indexes :id, type: :integer
      indexes :title, type: :text, analyzer: :russian
    end
  end

  private

  # Устанавливаем дату создания для новой статьи
  def default_values
    return unless new_record?

    self.changed_on = DateTime.current
  end
end
