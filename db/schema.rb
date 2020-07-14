# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_10_072200) do

  create_table "homeworks", force: :cascade do |t|
    t.date "work_on"
    t.string "note"
    t.boolean "work_namea"
    t.boolean "work_nameb"
    t.boolean "work_namec"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "teacher_flag"
    t.string "work_check"
    t.string "mark_homeworka"
    t.string "mark_homeworkb"
    t.string "mark_homeworkc"
    t.string "edit_mark_homeworka"
    t.string "edit_mark_homeworkb"
    t.string "edit_mark_homeworkc"
    t.boolean "check"
    t.string "check_teacher_answer"
    t.index ["user_id"], name: "index_homeworks_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "body"
    t.string "youtube_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.date "worked_on"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.boolean "teacher", default: false
    t.string "search"
    t.string "teacher_uid"
    t.string "student_uid"
    t.string "category_class"
    t.string "category_work"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.text "body"
    t.string "youtube_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

end
