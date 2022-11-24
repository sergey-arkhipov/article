class Text < ApplicationRecord
  # include Searchable
  belongs_to :article
  after_save :sets_active_text
  after_save :callback_elastick

  private

  # Set last text as active.
  def sets_active_text
    Article.find(article_id).update(active_text_id: id)
  end

  def callback_elastick
    Article.__elasticsearch__.create_index!
    Article.import
  end

end
