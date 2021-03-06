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

ActiveRecord::Schema.define(version: 20140601023223) do

  create_table "book_orders", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_sections", force: true do |t|
    t.integer  "excitement_page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", force: true do |t|
    t.integer  "excitement_page_id"
    t.string   "name"
    t.string   "isbn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "books", ["excitement_page_id"], name: "index_books_on_excitement_page_id"

  create_table "communities", force: true do |t|
    t.string   "name"
    t.string   "accountid"
    t.string   "latitude"
    t.string   "longitude"
    t.integer  "community_profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  create_table "community_profiles", force: true do |t|
    t.integer  "community_id"
    t.string   "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "community_profiles", ["community_id"], name: "index_community_profiles_on_community_id"

  create_table "community_sections", force: true do |t|
    t.integer  "excitement_page_id"
    t.string   "community_text"
    t.integer  "community_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "excitement_pages", force: true do |t|
    t.string   "title"
    t.text     "intro_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "summary_text"
  end

  create_table "photos", force: true do |t|
    t.binary   "raw_data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "imageable_id"
    t.string   "imageable_type"
  end

  create_table "testimonials", force: true do |t|
    t.string   "photo_caption"
    t.string   "text_block"
    t.string   "speaker_name"
    t.string   "speaker_role"
    t.integer  "excitement_page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
