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

ActiveRecord::Schema.define(version: 2020_03_24_194630) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendars", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "nutritionist_id"
    t.bigint "guest_id"
    t.index ["guest_id"], name: "index_calendars_on_guest_id"
    t.index ["nutritionist_id"], name: "index_calendars_on_nutritionist_id"
  end

  create_table "consultation_spots", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "color"
    t.bigint "nutritionist_id"
    t.index ["nutritionist_id"], name: "index_consultation_spots_on_nutritionist_id"
  end

  create_table "consultations", force: :cascade do |t|
    t.boolean "status"
    t.bigint "nutritionist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "guest_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.bigint "consultation_spot_id"
    t.index ["consultation_spot_id"], name: "index_consultations_on_consultation_spot_id"
    t.index ["guest_id"], name: "index_consultations_on_guest_id"
    t.index ["nutritionist_id"], name: "index_consultations_on_nutritionist_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "event"
    t.string "members"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "nutritionist_id"
    t.bigint "consultation_spot_id"
    t.index ["consultation_spot_id"], name: "index_tasks_on_consultation_spot_id"
    t.index ["nutritionist_id"], name: "index_tasks_on_nutritionist_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.integer "age"
    t.string "access_token"
    t.datetime "expires_at"
    t.string "refresh_token"
    t.string "name"
    t.string "address"
    t.string "gender"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "consultations", "consultation_spots"
  add_foreign_key "tasks", "consultation_spots"
end
