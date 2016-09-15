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

ActiveRecord::Schema.define(version: 20160911064642) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

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

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "albums", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "imageable_id"
    t.string   "imageable_type"
  end

  add_index "albums", ["imageable_id", "imageable_type"], name: "index_albums_on_imageable_id_and_imageable_type", using: :btree

  create_table "areas", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "business_id"
  end

  create_table "assignments", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "business_id"
  end

  create_table "attempted_solutions", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "issue_id"
  end

  add_index "attempted_solutions", ["issue_id"], name: "index_attempted_solutions_on_issue_id", using: :btree

  create_table "businesses", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "intro"
  end

  create_table "complaints", force: true do |t|
    t.text     "description"
    t.text     "name"
    t.text     "rectify"
    t.boolean  "internal"
    t.text     "master_spec"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "step"
    t.string   "priority"
    t.text     "cust_name"
  end

  create_table "department_areas", force: true do |t|
    t.integer  "department_id"
    t.integer  "area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "business_id"
  end

  add_index "department_areas", ["area_id"], name: "index_department_areas_on_area_id", using: :btree
  add_index "department_areas", ["department_id"], name: "index_department_areas_on_department_id", using: :btree

  create_table "departments", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "business_id"
  end

  create_table "detailed_steps", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "issue_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "number"
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
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "location"
    t.string   "description"
    t.string   "name"
    t.string   "location_id"
    t.integer  "imageable_id"
    t.string   "imageable_type"
  end

  add_index "images", ["imageable_id", "imageable_type"], name: "index_images_on_imageable_id_and_imageable_type", using: :btree

  create_table "impacts", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "business_id"
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
    t.text     "workaround"
    t.string   "area_impacted"
    t.integer  "view_counter"
    t.integer  "user_id"
    t.integer  "impact_id"
    t.date     "review_date"
    t.string   "i_type"
    t.string   "author"
    t.string   "state"
    t.integer  "business_id"
    t.integer  "department_area_id"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.hstore   "preferences"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "issues", ["impact_id"], name: "index_issues_on_impact_id", using: :btree
  add_index "issues", ["preferences"], name: "index_issues_on_preferences", using: :gin
  add_index "issues", ["user_id"], name: "index_issues_on_user_id", using: :btree

  create_table "jobs", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "department_area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  add_index "jobs", ["department_area_id"], name: "index_jobs_on_department_area_id", using: :btree

  create_table "lineups", force: true do |t|
    t.integer  "position_number"
    t.string   "job_number"
    t.string   "master_spec"
    t.string   "machine"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cust_name"
    t.string   "timestamp"
  end

  create_table "locations", force: true do |t|
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_area_id"
    t.string   "name"
    t.string   "info"
  end

  create_table "media", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.integer  "image_id"
  end

  add_index "media", ["image_id"], name: "index_media_on_image_id", using: :btree
  add_index "media", ["imageable_id", "imageable_type"], name: "index_media_on_imageable_id_and_imageable_type", using: :btree

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

  add_index "notes", ["issue_id"], name: "index_notes_on_issue_id", using: :btree

  create_table "processareas", force: true do |t|
    t.integer  "complaint_id"
    t.string   "process_area_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "processareas", ["complaint_id"], name: "index_processareas_on_complaint_id", using: :btree

  create_table "qwers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "records", force: true do |t|
    t.integer  "recordable_id"
    t.string   "recordable_type"
    t.integer  "user_id"
    t.integer  "issue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "records", ["issue_id"], name: "index_records_on_issue_id", using: :btree
  add_index "records", ["recordable_id", "recordable_type"], name: "index_records_on_recordable_id_and_recordable_type", using: :btree
  add_index "records", ["user_id"], name: "index_records_on_user_id", using: :btree

  create_table "reviews", force: true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "issue_id"
    t.string   "type"
    t.string   "state"
    t.datetime "review_date"
  end

  add_index "reviews", ["issue_id"], name: "index_reviews_on_issue_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

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
    t.integer  "business_id"
  end

  create_table "solutions", force: true do |t|
    t.integer  "issue_id"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "solutions", ["issue_id"], name: "index_solutions_on_issue_id", using: :btree

  create_table "steps", force: true do |t|
    t.string   "description"
    t.integer  "step_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "job_id"
  end

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
    t.integer  "business_id"
    t.boolean  "creator"
    t.string   "permType"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
