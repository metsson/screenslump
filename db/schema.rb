# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141103173345) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categorizations", force: true do |t|
    t.integer "slump_id"
    t.integer "genre_id"
  end

  create_table "genres", force: true do |t|
    t.string "name"
  end

  create_table "slumps", force: true do |t|
    t.integer  "year"
    t.integer  "hits",       default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sort_id"
    t.string   "title"
    t.text     "plot"
    t.string   "imdbid",                 null: false
  end

  add_index "slumps", ["title", "imdbid"], name: "index_slumps_on_title_and_imdbid", using: :btree

  create_table "sorts", force: true do |t|
    t.string "name", default: "unknown"
  end

  add_index "sorts", ["name"], name: "index_sorts_on_name", using: :btree

end
