class CreateTexts < ActiveRecord::Migration[7.0]
  def change
    create_table :texts do |t|
      t.text :text
      t.datetime :chanded_on, default: -> { 'CURRENT_TIMESTAMP' }
      t.boolean :archive
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
