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

ActiveRecord::Schema.define(version: 20160205223203) do

  create_table "auth_tokens", force: :cascade do |t|
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "expired_at"
    t.integer  "user_id"
  end

  create_table "identities", force: :cascade do |t|
    t.string  "provider"
    t.string  "uid"
    t.string  "email"
    t.string  "password_digest"
    t.integer "user_id"
    t.string  "password_salt"
  end

  create_table "movies", force: :cascade do |t|
    t.string   "title"
    t.string   "release"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "imdb_id"
    t.string   "poster"
    t.string   "genre"
    t.string   "imdb_rating"
    t.string   "imdb_type"
  end

  create_table "movies_users", force: :cascade do |t|
    t.integer "movie_id"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
