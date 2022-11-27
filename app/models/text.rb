class Text < ApplicationRecord
  # include Searchable
  belongs_to :article
  after_save :sets_active_text, :callback_elastick
  after_destroy :callback_elastick
  validates :text, presence: true

  private

  # Set last text as active.
  def sets_active_text
    Article.find(article_id).update(active_text_id: id, changed_on: DateTime.current)
  end

  def callback_elastick
    Article.__elasticsearch__.create_index!
    Article.import
  end
end
