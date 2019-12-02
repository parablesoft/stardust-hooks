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

ActiveRecord::Schema.define(version: 20191202155608) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_audits", force: :cascade do |t|
    t.integer  "book_id"
    t.string   "test"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_book_audits_on_book_id", using: :btree
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stardust_events", force: :cascade do |t|
    t.integer "hook_id"
    t.text    "content"
    t.index ["hook_id"], name: "index_stardust_events_on_hook_id", using: :btree
  end

  create_table "stardust_hooks", force: :cascade do |t|
    t.string "name"
    t.string "target_url"
    t.text   "configuration"
    t.text   "events",        default: [], array: true
  end

  add_foreign_key "book_audits", "books"
end
