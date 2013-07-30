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

ActiveRecord::Schema.define(:version => 20130725211749) do

  create_table "activities", :force => true do |t|
    t.integer  "activity_verb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.integer  "channel_id"
  end

  add_index "activities", ["activity_verb_id"], :name => "index_activities_on_activity_verb_id"
  add_index "activities", ["channel_id"], :name => "index_activities_on_channel_id"

  create_table "activity_actions", :force => true do |t|
    t.integer  "actor_id"
    t.integer  "activity_object_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "follow",             :default => false
    t.boolean  "author",             :default => false
    t.boolean  "user_author",        :default => false
    t.boolean  "owner",              :default => false
  end

  add_index "activity_actions", ["activity_object_id"], :name => "index_activity_actions_on_activity_object_id"
  add_index "activity_actions", ["actor_id"], :name => "index_activity_actions_on_actor_id"

  create_table "activity_object_activities", :force => true do |t|
    t.integer  "activity_id"
    t.integer  "activity_object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "object_type"
  end

  add_index "activity_object_activities", ["activity_id"], :name => "index_activity_object_activities_on_activity_id"
  add_index "activity_object_activities", ["activity_object_id"], :name => "index_activity_object_activities_on_activity_object_id"

  create_table "activity_object_properties", :force => true do |t|
    t.integer "activity_object_id"
    t.integer "property_id"
    t.string  "type"
  end

  add_index "activity_object_properties", ["activity_object_id"], :name => "index_activity_object_properties_on_activity_object_id"
  add_index "activity_object_properties", ["property_id"], :name => "index_activity_object_properties_on_property_id"

  create_table "activity_objects", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "object_type",    :limit => 45
    t.integer  "like_count",                   :default => 0
    t.string   "title",                        :default => ""
    t.text     "description"
    t.integer  "follower_count",               :default => 0
    t.integer  "visit_count",                  :default => 0
  end

  create_table "activity_verbs", :force => true do |t|
    t.string   "name",       :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "actors", :force => true do |t|
    t.string   "name"
    t.string   "email",              :default => "",   :null => false
    t.string   "slug"
    t.string   "subject_type"
    t.boolean  "notify_by_email",    :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activity_object_id"
  end

  add_index "actors", ["activity_object_id"], :name => "index_actors_on_activity_object_id"
  add_index "actors", ["email"], :name => "index_actors_on_email"
  add_index "actors", ["slug"], :name => "index_actors_on_slug", :unique => true

  create_table "actors_stylists", :id => false, :force => true do |t|
    t.integer "actor_id",   :null => false
    t.integer "stylist_id", :null => false
  end

  add_index "actors_stylists", ["actor_id", "stylist_id"], :name => "index_actors_stylists_on_actor_id_and_stylist_id"

  create_table "addresses", :force => true do |t|
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "addressable_id",   :null => false
    t.string   "addressable_type", :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "addresses", ["addressable_type", "addressable_id"], :name => "index_addresses_on_addressable_type_and_addressable_id"

  create_table "affiliate_clothing_items", :force => true do |t|
    t.integer "activity_object_id"
    t.string  "item_url"
    t.string  "mpn"
    t.string  "upc"
    t.string  "sku"
    t.boolean "is_accessory"
    t.string  "skimlinks_product_id"
    t.integer "skimlinks_group_id"
  end

  create_table "ask_hcits", :force => true do |t|
    t.integer  "clothing_item_id",             :null => false
    t.integer  "sender_id",                    :null => false
    t.integer  "receiver_id",                  :null => false
    t.integer  "user_scored_clothing_item_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "ask_hcits", ["clothing_item_id"], :name => "index_ask_hcits_on_clothing_item_id"
  add_index "ask_hcits", ["receiver_id"], :name => "index_ask_hcits_on_receiver_id"
  add_index "ask_hcits", ["sender_id"], :name => "index_ask_hcits_on_sender_id"
  add_index "ask_hcits", ["user_scored_clothing_item_id"], :name => "index_ask_hcits_on_user_scored_clothing_item_id"

  create_table "audiences", :force => true do |t|
    t.integer "relation_id"
    t.integer "activity_id"
  end

  add_index "audiences", ["activity_id"], :name => "index_audiences_on_activity_id"
  add_index "audiences", ["relation_id"], :name => "index_audiences_on_relation_id"

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "avatars", :force => true do |t|
    t.integer  "actor_id"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.boolean  "active",            :default => true
  end

  add_index "avatars", ["actor_id"], :name => "index_avatars_on_actor_id"

  create_table "badges", :force => true do |t|
    t.string "name"
    t.string "description"
    t.string "icon"
  end

  add_index "badges", ["name"], :name => "index_badges_on_name"

  create_table "badgings", :force => true do |t|
    t.boolean  "seen",         :default => false
    t.integer  "badge_id"
    t.integer  "subject_id"
    t.string   "subject_type"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "badgings", ["seen"], :name => "index_badgings_on_seen"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "source"
    t.integer  "source_identifier"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "categories", ["name"], :name => "index_categories_on_name"
  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"

  create_table "channels", :force => true do |t|
    t.integer  "author_id"
    t.integer  "owner_id"
    t.integer  "user_author_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "channels", ["author_id"], :name => "index_channels_on_author_id"
  add_index "channels", ["owner_id"], :name => "index_channels_on_owner_id"
  add_index "channels", ["user_author_id"], :name => "index_channels_on_user_author_id"

  create_table "closets", :force => true do |t|
    t.string   "name"
    t.integer  "actor_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "closets", ["actor_id"], :name => "index_closets_on_actor_id"

  create_table "closets_clothing_items", :id => false, :force => true do |t|
    t.integer "closet_id"
    t.integer "clothing_item_id"
  end

  add_index "closets_clothing_items", ["closet_id", "clothing_item_id"], :name => "closets_clothing_items_closet_item_index"
  add_index "closets_clothing_items", ["clothing_item_id", "closet_id"], :name => "closets_clothing_items_item_closet_index"

  create_table "clothing_items", :force => true do |t|
    t.string   "name"
    t.decimal  "price",                           :precision => 8, :scale => 2
    t.text     "description"
    t.string   "imageurl"
    t.string   "currency"
    t.integer  "manufacturer_id"
    t.integer  "heir_id"
    t.string   "heir_type"
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
    t.integer  "activity_object_id"
    t.integer  "gender",             :limit => 2
    t.string   "age"
    t.integer  "category_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "clothing_items", ["category_id"], :name => "index_clothing_items_on_category_id"
  add_index "clothing_items", ["heir_id"], :name => "index_clothing_items_on_heir_id"
  add_index "clothing_items", ["heir_type"], :name => "index_clothing_items_on_heir_type"

  create_table "clothing_items_outfits", :id => false, :force => true do |t|
    t.integer "clothing_item_id"
    t.integer "outfit_id"
  end

  add_index "clothing_items_outfits", ["clothing_item_id", "outfit_id"], :name => "index_clothing_items_outfits_on_clothing_item_id_and_outfit_id"
  add_index "clothing_items_outfits", ["outfit_id", "clothing_item_id"], :name => "index_clothing_items_outfits_on_outfit_id_and_clothing_item_id"

  create_table "clothing_items_retailers", :id => false, :force => true do |t|
    t.integer "clothing_item_id"
    t.integer "retailer_id"
  end

  add_index "clothing_items_retailers", ["clothing_item_id", "retailer_id"], :name => "clothing_items_retailers_clothing_retailer"
  add_index "clothing_items_retailers", ["retailer_id", "clothing_item_id"], :name => "clothing_items_retailers_retailer_clothing"

  create_table "comments", :force => true do |t|
    t.integer  "activity_object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["activity_object_id"], :name => "index_comments_on_activity_object_id"

  create_table "contacts", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "inverse_id"
    t.integer  "ties_count",  :default => 0
  end

  add_index "contacts", ["inverse_id"], :name => "index_contacts_on_inverse_id"
  add_index "contacts", ["receiver_id"], :name => "index_contacts_on_receiver_id"
  add_index "contacts", ["sender_id"], :name => "index_contacts_on_sender_id"

  create_table "conversations", :force => true do |t|
    t.string   "subject",    :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "documents", :force => true do |t|
    t.string   "type"
    t.integer  "activity_object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.string   "file_file_size"
    t.boolean  "file_processing"
  end

  add_index "documents", ["activity_object_id"], :name => "index_documents_on_activity_object_id"

  create_table "events", :force => true do |t|
    t.integer  "activity_object_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean  "all_day"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "room_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "frequency",          :default => 0
    t.integer  "interval"
    t.integer  "days",               :default => 0
    t.integer  "interval_flag",      :default => 0
  end

  add_index "events", ["room_id"], :name => "index_events_on_room_id"

  create_table "facebook_user_clothing_invites", :force => true do |t|
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

  create_table "groups", :force => true do |t|
    t.integer  "actor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["actor_id"], :name => "index_groups_on_actor_id"

  create_table "linked_clothing_items", :force => true do |t|
    t.string  "item_url",           :null => false
    t.integer "activity_object_id"
  end

  create_table "links", :force => true do |t|
    t.integer  "activity_object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "callback_url"
    t.string   "image"
    t.integer  "width",              :default => 470
    t.integer  "height",             :default => 353
  end

  add_index "links", ["activity_object_id"], :name => "index_links_on_activity_object_id"

  create_table "manufacturers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notifications", :force => true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              :default => ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                :default => false
    t.datetime "updated_at",                              :null => false
    t.datetime "created_at",                              :null => false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
  end

  add_index "notifications", ["conversation_id"], :name => "index_notifications_on_conversation_id"

  create_table "outfits", :force => true do |t|
    t.string   "name"
    t.integer  "closet_id"
    t.integer  "activity_object_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.hstore   "info"
    t.string   "outfit_image_file_name"
    t.string   "outfit_image_content_type"
    t.string   "outfit_image_file_size"
    t.boolean  "outfit_image_processing"
  end

  add_index "outfits", ["activity_object_id"], :name => "index_outfits_on_activity_object_id"
  add_index "outfits", ["closet_id"], :name => "index_outfits_on_closet_id"

  create_table "permissions", :force => true do |t|
    t.string   "action"
    t.string   "object"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "points", :force => true do |t|
    t.integer  "value",       :default => 0
    t.string   "action"
    t.string   "description"
    t.boolean  "repeatable",  :default => false
    t.integer  "cooldown",    :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "points", ["action"], :name => "index_points_on_action"

  create_table "points_users", :force => true do |t|
    t.integer  "point_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "points_users", ["point_id"], :name => "index_points_users_on_point_id"
  add_index "points_users", ["user_id"], :name => "index_points_users_on_user_id"

  create_table "posts", :force => true do |t|
    t.integer  "activity_object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["activity_object_id"], :name => "index_posts_on_activity_object_id"

  create_table "profiles", :force => true do |t|
    t.integer  "actor_id"
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "organization", :limit => 45
    t.string   "phone",        :limit => 45
    t.string   "mobile",       :limit => 45
    t.string   "fax",          :limit => 45
    t.string   "address"
    t.string   "city"
    t.string   "zipcode",      :limit => 45
    t.string   "province",     :limit => 45
    t.string   "country",      :limit => 45
    t.integer  "prefix_key"
    t.string   "description"
    t.string   "experience"
    t.string   "website"
    t.string   "skype",        :limit => 45
    t.string   "im",           :limit => 45
  end

  add_index "profiles", ["actor_id"], :name => "index_profiles_on_actor_id"

  create_table "receipts", :force => true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                                  :null => false
    t.boolean  "read",                          :default => false
    t.boolean  "trashed",                       :default => false
    t.boolean  "deleted",                       :default => false
    t.string   "mailbox_type",    :limit => 25
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "receipts", ["notification_id"], :name => "index_receipts_on_notification_id"

  create_table "relation_permissions", :force => true do |t|
    t.integer  "relation_id"
    t.integer  "permission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relation_permissions", ["permission_id"], :name => "index_relation_permissions_on_permission_id"
  add_index "relation_permissions", ["relation_id"], :name => "index_relation_permissions_on_relation_id"

  create_table "relations", :force => true do |t|
    t.integer  "actor_id"
    t.string   "type"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sender_type"
    t.string   "receiver_type"
    t.string   "ancestry"
  end

  add_index "relations", ["actor_id"], :name => "index_relations_on_actor_id"
  add_index "relations", ["ancestry"], :name => "index_relations_on_ancestry"

  create_table "retailers", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "domain"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rooms", :force => true do |t|
    t.integer  "actor_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "rooms", ["actor_id"], :name => "index_rooms_on_actor_id"

  create_table "stylist_client_requests", :force => true do |t|
    t.integer  "stylist_id",          :null => false
    t.integer  "actor_id",            :null => false
    t.boolean  "stylist_approved"
    t.boolean  "client_approved"
    t.datetime "stylist_approved_on"
    t.datetime "client_approved_on"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "stylist_client_requests", ["actor_id"], :name => "index_stylist_client_requests_on_actor_id"
  add_index "stylist_client_requests", ["stylist_id"], :name => "index_stylist_client_requests_on_stylist_id"

  create_table "stylists", :force => true do |t|
    t.integer  "actor_id",      :null => false
    t.string   "youtube_video"
    t.text     "about_me"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "google"
    t.string   "pinterest"
    t.string   "website"
    t.string   "phone"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "stylists", ["actor_id"], :name => "index_stylists_on_actor_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "tasks", :force => true do |t|
    t.string   "title",                              :null => false
    t.text     "description"
    t.datetime "due_date"
    t.datetime "completion_date"
    t.boolean  "is_complete",     :default => false
    t.integer  "client_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "actor_id"
  end

  create_table "ties", :force => true do |t|
    t.integer  "contact_id"
    t.integer  "relation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ties", ["contact_id"], :name => "index_ties_on_contact_id"
  add_index "ties", ["relation_id"], :name => "index_ties_on_relation_id"

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
    t.string   "encrypted_password",     :limit => 128, :default => "",          :null => false
    t.string   "password_salt"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
    t.integer  "actor_id"
    t.string   "language"
    t.boolean  "connected",                             :default => false
    t.string   "status",                                :default => "available"
    t.string   "email"
    t.boolean  "chat_enabled",                          :default => true
    t.integer  "points_earned_cache"
  end

  add_index "users", ["actor_id"], :name => "index_users_on_actor_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  add_foreign_key "activities", "activity_verbs", :name => "index_activities_on_activity_verb_id"
  add_foreign_key "activities", "channels", :name => "index_activities_on_channel_id"

  add_foreign_key "activity_actions", "activity_objects", :name => "index_activity_actions_on_activity_object_id"
  add_foreign_key "activity_actions", "actors", :name => "index_activity_actions_on_actor_id"

  add_foreign_key "activity_object_activities", "activities", :name => "index_activity_object_activities_on_activity_id"
  add_foreign_key "activity_object_activities", "activity_objects", :name => "activity_object_activities_on_activity_object_id"

  add_foreign_key "activity_object_properties", "activity_objects", :name => "index_activity_object_properties_on_activity_object_id"
  add_foreign_key "activity_object_properties", "activity_objects", :name => "index_activity_object_properties_on_property_id", :column => "property_id"

  add_foreign_key "actors", "activity_objects", :name => "actors_on_activity_object_id"

  add_foreign_key "audiences", "activities", :name => "audiences_on_activity_id"
  add_foreign_key "audiences", "relations", :name => "audiences_on_relation_id"

  add_foreign_key "authentications", "users", :name => "authentications_on_user_id"

  add_foreign_key "avatars", "actors", :name => "avatars_on_actor_id"

  add_foreign_key "channels", "actors", :name => "index_channels_on_author_id", :column => "author_id"
  add_foreign_key "channels", "actors", :name => "index_channels_on_owner_id", :column => "owner_id"
  add_foreign_key "channels", "actors", :name => "index_channels_on_user_author_id", :column => "user_author_id"

  add_foreign_key "comments", "activity_objects", :name => "comments_on_activity_object_id"

  add_foreign_key "contacts", "actors", :name => "contacts_on_receiver_id", :column => "receiver_id"
  add_foreign_key "contacts", "actors", :name => "contacts_on_sender_id", :column => "sender_id"

  add_foreign_key "documents", "activity_objects", :name => "documents_on_activity_object_id"

  add_foreign_key "events", "activity_objects", :name => "events_on_activity_object_id"
  add_foreign_key "events", "rooms", :name => "index_events_on_room_id"

  add_foreign_key "groups", "actors", :name => "groups_on_actor_id"

  add_foreign_key "links", "activity_objects", :name => "links_on_activity_object_id"

  add_foreign_key "notifications", "conversations", :name => "notifications_on_conversation_id"

  add_foreign_key "posts", "activity_objects", :name => "posts_on_activity_object_id"

  add_foreign_key "profiles", "actors", :name => "profiles_on_actor_id"

  add_foreign_key "receipts", "notifications", :name => "receipts_on_notification_id"

  add_foreign_key "relation_permissions", "permissions", :name => "relation_permissions_on_permission_id"
  add_foreign_key "relation_permissions", "relations", :name => "relation_permissions_on_relation_id"

  add_foreign_key "relations", "actors", :name => "relations_on_actor_id"

  add_foreign_key "ties", "contacts", :name => "ties_on_contact_id"
  add_foreign_key "ties", "relations", :name => "ties_on_relation_id"

  add_foreign_key "users", "actors", :name => "users_on_actor_id"

end
