# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_11_24_101232) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "author"
    t.string "title"
    t.integer "status"
    t.integer "version"
    t.datetime "changed_on", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "active_text_id"
  end

  create_table "texts", force: :cascade do |t|
    t.text "text"
    t.datetime "changed_on", default: -> { "CURRENT_TIMESTAMP" }
    t.boolean "archive"
    t.bigint "article_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_texts_on_article_id"
  end

  add_foreign_key "texts", "articles"
end
