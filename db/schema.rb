ActiveRecord::Schema[7.0].define(version: 2023_01_27_021906) do
  enable_extension "plpgsql"

  create_table "questions", force: :cascade do |t|
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "story_id"
    t.string "answer", null: false
    t.index ["story_id"], name: "index_questions_on_story_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "title", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
