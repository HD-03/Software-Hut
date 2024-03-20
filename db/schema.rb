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

ActiveRecord::Schema[7.0].define(version: 2024_03_20_152657) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "username"
    t.string "hashed_password"
    t.string "full_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "students", force: :cascade do |t|
    t.string "username"
    t.string "hashed_password"
    t.string "full_name"
    t.string "email"
    t.integer "avatar_id"
    t.integer "background_id"
    t.boolean "unchecked_background"
    t.integer "level"
    t.integer "xp_points"
    t.integer "reward_points"
    t.boolean "membership"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students_tasks", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "task_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_students_tasks_on_student_id"
    t.index ["task_id"], name: "index_students_tasks_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "teacher_user_id", null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "time_set", null: false
    t.datetime "deadline", null: false
    t.integer "base_experience_points", null: false
    t.integer "status", default: 0, null: false
    t.string "attachment_paths", default: [], array: true
    t.boolean "recording_boolean", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string "username"
    t.string "hashed_password"
    t.string "full_name"
    t.string "email"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "hashed_pw", null: false
    t.string "name"
    t.integer "role", default: 0, null: false
    t.integer "unlocked_avatar_ids", default: [], array: true
    t.integer "unlocked_background_ids", default: [], array: true
    t.integer "level", default: 1, null: false
    t.integer "current_experience_points", default: 0, null: false
    t.integer "level_up_required_points", default: 0, null: false
    t.boolean "mature", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "students_tasks", "students"
  add_foreign_key "students_tasks", "tasks"
end
