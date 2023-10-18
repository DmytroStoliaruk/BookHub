# frozen_string_literal: true

ActiveRecord::Schema[7.0].define(version: 20_231_018_065_130) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.string "author", null: false
    t.string "isbn"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
