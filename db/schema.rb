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

ActiveRecord::Schema.define(:version => 20120326191249) do

  create_table "clothing_items", :force => true do |t|
    t.string   "name"
    t.decimal  "price",           :precision => 8, :scale => 2
    t.text     "description"
    t.string   "imageurl"
    t.string   "currency"
    t.integer  "retailer_id"
    t.integer  "manufacturer_id"
    t.integer  "heir_id"
    t.string   "heir_type"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  add_index "clothing_items", ["heir_id"], :name => "index_clothing_items_on_heir_id"
  add_index "clothing_items", ["heir_type"], :name => "index_clothing_items_on_heir_type"

  create_table "facebook_user_clothing_invites", :id => false, :force => true do |t|
    t.integer  "facebook_id",      :limit => 8
    t.integer  "user_id"
    t.integer  "clothing_item_id"
    t.boolean  "accepted"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "facebook_user_clothing_invites", ["accepted"], :name => "index_facebook_user_clothing_invites_on_accepted"
  add_index "facebook_user_clothing_invites", ["facebook_id"], :name => "index_facebook_user_clothing_invites_on_facebook_id"
  add_index "facebook_user_clothing_invites", ["user_id"], :name => "index_facebook_user_clothing_invites_on_user_id"

  create_table "linked_clothing_items", :force => true do |t|
    t.string "item_url", :null => false
  end

  create_table "user_asked_clothing_items", :id => false, :force => true do |t|
    t.integer  "user_id",          :null => false
    t.integer  "clothing_item_id", :null => false
    t.string   "referrer"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "user_asked_clothing_items", ["clothing_item_id"], :name => "index_user_asked_clothing_items_on_clothing_item_id"
  add_index "user_asked_clothing_items", ["user_id"], :name => "index_user_asked_clothing_items_on_user_id"

  create_table "user_bookmarked_clothing_items", :id => false, :force => true do |t|
    t.integer  "user_id",          :null => false
    t.integer  "clothing_item_id", :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "user_bookmarked_clothing_items", ["clothing_item_id"], :name => "index_user_bookmarked_clothing_items_on_clothing_item_id"
  add_index "user_bookmarked_clothing_items", ["user_id"], :name => "index_user_bookmarked_clothing_items_on_user_id"

  create_table "user_scored_clothing_items", :id => false, :force => true do |t|
    t.integer  "user_id",          :null => false
    t.integer  "clothing_item_id", :null => false
    t.decimal  "price"
    t.boolean  "love"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "user_scored_clothing_items", ["clothing_item_id"], :name => "index_user_scored_clothing_items_on_clothing_item_id"
  add_index "user_scored_clothing_items", ["love"], :name => "index_user_scored_clothing_items_on_love"
  add_index "user_scored_clothing_items", ["user_id"], :name => "index_user_scored_clothing_items_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "uid"
    t.string   "provider"
    t.string   "token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
