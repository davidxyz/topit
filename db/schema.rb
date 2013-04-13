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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130411171529) do

# Could not dump table "comments" because of following StandardError
#   Unknown type 'likes' for column 'integer'

  create_table "microposts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "posttype"
    t.string   "title"
    t.integer  "likes",      :default => 0
    t.integer  "integer",    :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "miniposts", :force => true do |t|
    t.text     "content"
    t.string   "name"
    t.string   "image"
    t.integer  "user_id"
    t.integer  "micropost_id"
    t.integer  "likes",        :default => 0
    t.integer  "integer",      :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "miniposts", ["user_id", "created_at"], :name => "index_miniposts_on_user_id_and_created_at"

  create_table "relationshipks", :force => true do |t|
    t.integer  "subscriber_id"
    t.integer  "subscribed_id"
    t.string   "post_ids"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "relationshipks", ["subscribed_id", "subscriber_id"], :name => "index_relationshipks_on_subscribed_id_and_subscriber_id", :unique => true
  add_index "relationshipks", ["subscribed_id"], :name => "index_relationshipks_on_subscribed_id"
  add_index "relationshipks", ["subscriber_id"], :name => "index_relationshipks_on_subscriber_id"

  create_table "relationshipls", :force => true do |t|
    t.integer  "liker_id"
    t.integer  "liked_id"
    t.string   "posttype",   :default => "micropost"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "relationshipls", ["liked_id"], :name => "index_relationshipls_on_liked_id"
  add_index "relationshipls", ["liker_id", "liked_id", "posttype"], :name => "index_relationshipls_on_liker_id_and_liked_id_and_posttype", :unique => true
  add_index "relationshipls", ["liker_id"], :name => "index_relationshipls_on_liker_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "remember_token"
    t.string   "password_digest"
    t.boolean  "admin",           :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
