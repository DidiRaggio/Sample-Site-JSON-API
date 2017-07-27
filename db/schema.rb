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

ActiveRecord::Schema.define(version: 20170118183455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "genre_tags", force: :cascade do |t|
    t.integer  "genre_id"
    t.integer  "pitch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_genre_tags_on_genre_id", using: :btree
    t.index ["pitch_id"], name: "index_genre_tags_on_pitch_id", using: :btree
  end

  create_table "genres", force: :cascade do |t|
    t.string   "name",       default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "pitches", force: :cascade do |t|
    t.string   "title",                 default: ""
    t.text     "body",                  default: ""
    t.string   "video",                 default: ""
    t.datetime "expected_release_date"
    t.string   "website",               default: ""
    t.integer  "user_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["user_id"], name: "index_pitches_on_user_id", using: :btree
  end

  create_table "platform_tags", force: :cascade do |t|
    t.integer  "platform_id"
    t.integer  "pitch_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["pitch_id"], name: "index_platform_tags_on_pitch_id", using: :btree
    t.index ["platform_id"], name: "index_platform_tags_on_platform_id", using: :btree
  end

  create_table "platforms", force: :cascade do |t|
    t.string   "name",       default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "submissions", force: :cascade do |t|
    t.integer  "pitch_id"
    t.boolean  "is_approved",   default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "dev_id"
    t.integer  "influencer_id"
    t.text     "dev_note",      default: ""
    t.text     "feedback",      default: ""
    t.boolean  "is_complete",   default: false
    t.index ["pitch_id"], name: "index_submissions_on_pitch_id", using: :btree
  end

  create_table "user_genre_tags", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "user_genre_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["user_genre_id"], name: "index_user_genre_tags_on_user_genre_id", using: :btree
    t.index ["user_id"], name: "index_user_genre_tags_on_user_id", using: :btree
  end

  create_table "user_genres", force: :cascade do |t|
    t.string   "name",       default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "auth_token",             default: ""
    t.boolean  "is_dev",                 default: true
    t.integer  "credit",                 default: 0
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "genre_tags", "genres"
  add_foreign_key "genre_tags", "pitches"
  add_foreign_key "platform_tags", "pitches"
  add_foreign_key "platform_tags", "platforms"
  add_foreign_key "submissions", "pitches"
  add_foreign_key "user_genre_tags", "user_genres"
  add_foreign_key "user_genre_tags", "users"
end
