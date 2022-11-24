class RemoveColumnFromArticle < ActiveRecord::Migration[7.0]
  def change
    remove_column :articles, :text, :string
  end
end
