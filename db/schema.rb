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

ActiveRecord::Schema.define(version: 20170816125326) do

  create_table "competitors", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "sex"
    t.string   "club"
    t.date     "birth_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "competitors_events", id: false, force: :cascade do |t|
    t.integer "event_id",      null: false
    t.integer "competitor_id", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "place"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lists", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "round"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_lists_on_event_id"
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "list_id"
    t.integer  "competitor_id"
    t.integer  "start_number"
    t.decimal  "score"
    t.integer  "place"
    t.decimal  "ex_points"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["competitor_id"], name: "index_scores_on_competitor_id"
    t.index ["list_id"], name: "index_scores_on_list_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
