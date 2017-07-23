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

ActiveRecord::Schema.define(version: 20170723064938) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients_projects", id: false, force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "project_id", null: false
  end

  create_table "history_records", force: :cascade do |t|
    t.bigint "project_id"
    t.datetime "moment"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_history_records_on_project_id"
  end

  create_table "nakamas", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.text "descr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_records", force: :cascade do |t|
    t.date "theday"
    t.integer "amount"
    t.bigint "nakama_id"
    t.bigint "project_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nakama_id"], name: "index_time_records_on_nakama_id"
    t.index ["project_id"], name: "index_time_records_on_project_id"
  end

  add_foreign_key "history_records", "projects"
  add_foreign_key "time_records", "nakamas"
  add_foreign_key "time_records", "projects"
end
