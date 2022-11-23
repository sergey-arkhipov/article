class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :author
      t.string :title
      t.text :text
      t.integer :status
      t.integer :version
      t.timestamp :changed_on

      t.timestamps
    end
  end
end
