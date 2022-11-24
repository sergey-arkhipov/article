class AddColumnToArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :active_text_id, :integer
  end
end
