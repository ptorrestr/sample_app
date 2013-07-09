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

ActiveRecord::Schema.define(version: 20130708135244) do

  create_table "credentials", force: true do |t|
    t.string   "consumer"
    t.string   "consumer_secret"
    t.string   "access"
    t.string   "access_secret"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "name_user"
  end

  add_index "credentials", ["user_id", "created_at"], name: "index_credentials_on_user_id_and_created_at"

  create_table "searches", force: true do |t|
    t.string   "query"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "credential_id"
    t.integer  "searchrest_id"
    t.string   "type"
    t.string   "kind"
  end

  add_index "searches", ["user_id", "created_at"], name: "index_searches_on_user_id_and_created_at"

  create_table "streamings", force: true do |t|
    t.string   "query"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "credential_id"
  end

  add_index "streamings", ["user_id", "created_at"], name: "index_streamings_on_user_id_and_created_at"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
