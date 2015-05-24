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

ActiveRecord::Schema.define(version: 20150523202956) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.string   "screen_name"
    t.integer  "twitter_id",  limit: 8
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "authors", ["twitter_id"], name: "index_authors_on_twitter_id", using: :btree

  create_table "twits", force: :cascade do |t|
    t.string   "body"
    t.integer  "origin_id",  limit: 8
    t.datetime "twit_date"
    t.integer  "author_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "twits", ["author_id"], name: "index_twits_on_author_id", using: :btree
  add_index "twits", ["origin_id"], name: "index_twits_on_origin_id", using: :btree

  add_foreign_key "twits", "authors"
end
