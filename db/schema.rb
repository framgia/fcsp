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

ActiveRecord::Schema.define(version: 20170310043400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "address"
    t.float    "longtitude"
    t.float    "latitude"
    t.boolean  "head_office"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "articles", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.string   "background_image"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "benefits", force: :cascade do |t|
    t.string   "company_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "candidates", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.integer  "job_id"
    t.integer  "interested_in"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "website"
    t.text     "introduction"
    t.string   "founder"
    t.integer  "company_size"
    t.date     "founder_on"
    t.string   "logo"
    t.string   "background_image"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "employees", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.string   "description"
    t.date     "start_time"
    t.integer  "role"
    t.integer  "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "images", force: :cascade do |t|
    t.integer  "team_introduction_id_id"
    t.string   "image_url"
    t.text     "caption"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["team_introduction_id_id"], name: "index_images_on_team_introduction_id_id", using: :btree
  end

  create_table "jobs", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "title"
    t.string   "describe"
    t.integer  "type_of_candidates"
    t.integer  "who_can_apply"
    t.string   "image_url"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "team_introductions", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "target_id"
    t.integer  "target_type"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
