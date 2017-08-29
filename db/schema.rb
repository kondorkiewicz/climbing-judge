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

ActiveRecord::Schema.define(version: 20170825090831) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competitors", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "sex"
    t.string "club"
    t.date "birth_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "competitors_events", id: false, force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "competitor_id", null: false
  end

  create_table "eliminations_results", id: :serial, force: :cascade do |t|
    t.integer "place"
    t.integer "competitor_id"
    t.integer "event_id"
    t.decimal "points"
    t.integer "first_route_place"
    t.integer "second_route_place"
    t.index ["competitor_id"], name: "index_eliminations_results_on_competitor_id"
    t.index ["event_id"], name: "index_eliminations_results_on_event_id"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "place"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "status"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "lists", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.string "round"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sex"
    t.string "name"
    t.index ["event_id"], name: "index_lists_on_event_id"
  end

  create_table "results", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.integer "competitor_id"
    t.integer "place"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competitor_id"], name: "index_results_on_competitor_id"
    t.index ["event_id"], name: "index_results_on_event_id"
  end

  create_table "scores", id: :serial, force: :cascade do |t|
    t.integer "list_id"
    t.integer "competitor_id"
    t.integer "start_number"
    t.decimal "score"
    t.integer "place"
    t.decimal "ex_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competitor_id"], name: "index_scores_on_competitor_id"
    t.index ["list_id"], name: "index_scores_on_list_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "eliminations_results", "competitors"
  add_foreign_key "eliminations_results", "events"
  add_foreign_key "events", "users"
  add_foreign_key "lists", "events"
  add_foreign_key "results", "competitors"
  add_foreign_key "results", "events"
  add_foreign_key "scores", "competitors"
  add_foreign_key "scores", "lists"
end
