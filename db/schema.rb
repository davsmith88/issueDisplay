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

ActiveRecord::Schema.define(version: 20140614073444) do

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "albums", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "imageable_id"
    t.string   "imageable_type"
  end

  add_index "albums", ["imageable_id", "imageable_type"], name: "index_albums_on_imageable_id_and_imageable_type"

  create_table "areas", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignments", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attempted_solutions", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "issue_id"
  end

  add_index "attempted_solutions", ["issue_id"], name: "index_attempted_solutions_on_issue_id"

  create_table "businesses", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "caption"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comment_type"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "department_areas", force: true do |t|
    t.integer  "department_id"
    t.integer  "area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "department_areas", ["area_id"], name: "index_department_areas_on_area_id"
  add_index "department_areas", ["department_id"], name: "index_department_areas_on_department_id"

  create_table "departments", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grants", force: true do |t|
    t.integer  "right_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.text     "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "album_id"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "imageable_type"
    t.integer  "imageable_id"
  end

  add_index "images", ["imageable_id"], name: "index_images_on_imageable_id"
  add_index "images", ["imageable_type"], name: "index_images_on_imageable_type"

  create_table "impacts", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issue_workarounds", force: true do |t|
    t.string  "description"
    t.integer "issue_id"
  end

  create_table "issues", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "view_counter"
    t.integer  "user_id"
    t.integer  "impact_id"
    t.datetime "review_date"
    t.integer  "department_area_id"
    t.string   "state"
    t.string   "i_type"
  end

  add_index "issues", ["impact_id"], name: "index_issues_on_impact_id"
  add_index "issues", ["state"], name: "index_issues_on_state"
  add_index "issues", ["user_id"], name: "index_issues_on_user_id"

  create_table "notes", force: true do |t|
    t.text     "context"
    t.integer  "reviewer_id"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "issue_id"
    t.boolean  "author_read"
    t.boolean  "checked"
    t.integer  "version_number"
  end

  add_index "notes", ["issue_id"], name: "index_notes_on_issue_id"

  create_table "records", force: true do |t|
    t.integer  "recordable_id"
    t.string   "recordable_type"
    t.integer  "user_id"
    t.integer  "issue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "message"
  end

  add_index "records", ["issue_id"], name: "index_records_on_issue_id"
  add_index "records", ["recordable_id", "recordable_type"], name: "index_records_on_recordable_id_and_recordable_type"
  add_index "records", ["user_id"], name: "index_records_on_user_id"

  create_table "rights", force: true do |t|
    t.string   "resource"
    t.string   "operation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "solutions", force: true do |t|
    t.integer  "issue_id"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "solutions", ["issue_id"], name: "index_solutions_on_issue_id"

  create_table "tests", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "title"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "versions", force: true do |t|
    t.string   "item_type",            null: false
    t.integer  "item_id",              null: false
    t.string   "event",                null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
    t.string   "department_area_name"
    t.string   "impact_name"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
