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

ActiveRecord::Schema.define(version: 20171030083914) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clusters", force: :cascade do |t|
    t.string "name"
    t.text "descr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "history_records", force: :cascade do |t|
    t.bigint "cluster_id"
    t.datetime "moment"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cluster_id"], name: "index_history_records_on_cluster_id"
    t.index ["moment"], name: "index_history_records_on_moment"
  end

  create_table "nakamas", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_rates", force: :cascade do |t|
    t.bigint "nakama_id", null: false
    t.bigint "project_id"
    t.float "hour_rate", null: false
    t.float "hour_cost", null: false
    t.datetime "active_from", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nakama_id"], name: "index_payment_rates_on_nakama_id"
    t.index ["project_id"], name: "index_payment_rates_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "cluster_id"
    t.string "name"
    t.text "descr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "options"
    t.index ["cluster_id"], name: "index_projects_on_cluster_id"
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
    t.index ["theday"], name: "index_time_records_on_theday"
  end

  create_table "timers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "started_at"
    t.integer "seconds"
    t.bigint "project_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_timers_on_project_id"
    t.index ["user_id"], name: "index_timers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "nakama_id"
    t.integer "perms"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nakama_id"], name: "index_users_on_nakama_id"
  end

  add_foreign_key "history_records", "clusters"
  add_foreign_key "payment_rates", "nakamas"
  add_foreign_key "payment_rates", "projects"
  add_foreign_key "projects", "clusters"
  add_foreign_key "time_records", "nakamas"
  add_foreign_key "time_records", "projects"
  add_foreign_key "timers", "projects"
  add_foreign_key "timers", "users"
  add_foreign_key "users", "nakamas"
end
