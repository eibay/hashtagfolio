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

ActiveRecord::Schema.define(version: 20150825041458) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "tag"
    t.integer  "image_count"
  end

  add_index "albums", ["user_id"], name: "index_albums_on_user_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.text     "caption"
    t.integer  "likes"
    t.string   "link"
    t.integer  "user_id"
    t.string   "url_low_res"
    t.string   "url_thumb"
    t.string   "url"
    t.string   "instagram_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "post_time"
  end

  add_index "images", ["user_id"], name: "index_images_on_user_id", using: :btree

  create_table "images_tags", id: false, force: :cascade do |t|
    t.integer "image_id"
    t.integer "tag_id"
  end

  add_index "images_tags", ["image_id"], name: "index_images_tags_on_image_id", using: :btree
  add_index "images_tags", ["tag_id"], name: "index_images_tags_on_tag_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "instagram_access_token"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "instagram_id"
    t.string   "profile_image_url"
    t.string   "name"
    t.string   "instagram_username"
  end

  add_foreign_key "albums", "users"
  add_foreign_key "images", "users"
end
