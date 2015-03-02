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

ActiveRecord::Schema.define(version: 20150302021113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apps", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "type",       null: false
    t.string   "slug",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id",    null: false
    t.string   "license"
  end

  add_index "apps", ["slug"], name: "index_apps_on_slug", unique: true, using: :btree
  add_index "apps", ["user_id"], name: "index_apps_on_user_id", using: :btree

  create_table "blog_articles", force: :cascade do |t|
    t.string   "title",      null: false
    t.string   "tagline"
    t.string   "slug",       null: false
    t.integer  "blog_id",    null: false
    t.text     "body",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "author_id",  null: false
  end

  add_index "blog_articles", ["author_id"], name: "index_blog_articles_on_author_id", using: :btree
  add_index "blog_articles", ["blog_id"], name: "index_blog_articles_on_blog_id", using: :btree
  add_index "blog_articles", ["slug"], name: "index_blog_articles_on_slug", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.integer  "app_id",     null: false
    t.integer  "user_id",    null: false
    t.string   "role",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",      null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "blog_articles", "apps", column: "blog_id"
  add_foreign_key "blog_articles", "users", column: "author_id"
end
