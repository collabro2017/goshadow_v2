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

ActiveRecord::Schema.define(version: 20160603153652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                    null: false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "assetable_id"
    t.string   "assetable_type"
  end

  add_index "assets", ["assetable_type", "assetable_id"], name: "index_assets_on_assetable_type_and_assetable_id", using: :btree

  create_table "experiences", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id",                 null: false
    t.string   "name",                            null: false
    t.text     "description"
    t.string   "location"
    t.boolean  "published",       default: false
    t.integer  "created_by_id"
    t.boolean  "archived",        default: false
  end

  create_table "groups", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id", null: false
    t.string   "name",            null: false
    t.string   "type",            null: false
  end

  add_index "groups", ["organization_id", "name", "type"], name: "index_groups_on_organization_id_and_name_and_type", unique: true, using: :btree

  create_table "invites", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id",   null: false
    t.integer  "invited_by_id",     null: false
    t.string   "email",             null: false
    t.integer  "experience_id"
    t.string   "name",              null: false
    t.string   "organization_role"
    t.string   "token",             null: false
    t.integer  "segment_id"
  end

  create_table "notes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "segment_id",               null: false
    t.integer  "reference_id"
    t.string   "text"
    t.datetime "start_time"
    t.integer  "seconds",      default: 0
    t.string   "status"
    t.integer  "user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                  null: false
    t.string   "team_size"
    t.string   "stripe_plan_id"
    t.string   "stripe_customer_id"
    t.string   "billing_email"
    t.integer  "last_activity_user_id"
    t.datetime "last_activity_time"
  end

  create_table "reference_groups", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reference_id", null: false
    t.integer  "group_id",     null: false
  end

  add_index "reference_groups", ["reference_id", "group_id"], name: "index_reference_groups_on_reference_id_and_group_id", unique: true, using: :btree

  create_table "reference_segments", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reference_id", null: false
    t.integer  "segment_id",   null: false
  end

  add_index "reference_segments", ["reference_id", "segment_id"], name: "index_reference_segments_on_reference_id_and_segment_id", unique: true, using: :btree

  create_table "references", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id", null: false
    t.string   "name",            null: false
    t.string   "type",            null: false
    t.integer  "created_by_id",   null: false
  end

  add_index "references", ["name", "type", "organization_id"], name: "index_references_on_name_and_type_and_organization_id", unique: true, using: :btree

  create_table "reports", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "experience_id",              null: false
    t.string   "name",                       null: false
    t.string   "type",                       null: false
    t.json     "data",          default: {}
    t.integer  "created_by_id",              null: false
    t.integer  "segment_id"
  end

  create_table "segments", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "experience_id",                  null: false
    t.string   "name",                           null: false
    t.string   "start_location"
    t.string   "end_location"
    t.integer  "sort_order"
    t.integer  "created_by_id"
    t.boolean  "archived",       default: false
  end

  add_index "segments", ["experience_id"], name: "index_segments_on_experience_id", using: :btree

  create_table "user_experiences", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",       null: false
    t.integer  "experience_id", null: false
  end

  add_index "user_experiences", ["user_id", "experience_id"], name: "index_user_experiences_on_user_id_and_experience_id", unique: true, using: :btree

  create_table "user_organizations", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",         null: false
    t.integer  "organization_id", null: false
    t.string   "role",            null: false
  end

  add_index "user_organizations", ["user_id", "organization_id"], name: "index_user_organizations_on_user_id_and_organization_id", unique: true, using: :btree

  create_table "user_segments", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    null: false
    t.integer  "segment_id", null: false
  end

  add_index "user_segments", ["user_id", "segment_id"], name: "index_user_segments_on_user_id_and_segment_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "first_name",                             null: false
    t.string   "last_name",                              null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "api_token"
    t.datetime "api_last_activity"
    t.boolean  "system_admin",           default: false
  end

  add_index "users", ["api_token"], name: "index_users_on_api_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
