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

ActiveRecord::Schema.define(version: 20170314073910) do

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
    t.index ["company_id"], name: "index_addresses_on_company_id", using: :btree
  end

  create_table "articles", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_articles_on_company_id", using: :btree
    t.index ["title"], name: "index_articles_on_title", using: :btree
    t.index ["user_id"], name: "index_articles_on_user_id", using: :btree
  end

  create_table "benefits", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["company_id"], name: "index_benefits_on_company_id", using: :btree
  end

  create_table "candidates", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "job_id"
    t.integer  "interested_in"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["job_id"], name: "index_candidates_on_job_id", using: :btree
    t.index ["user_id"], name: "index_candidates_on_user_id", using: :btree
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "website"
    t.text     "introduction"
    t.string   "founder"
    t.integer  "company_size"
    t.string   "country"
    t.date     "founder_on"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["name"], name: "index_companies_on_name", using: :btree
    t.index ["website"], name: "index_companies_on_website", using: :btree
  end

  create_table "education_abouts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "education_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "education_comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_education_comments_on_user_id", using: :btree
  end

  create_table "education_course_members", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_education_course_members_on_user_id", using: :btree
  end

  create_table "education_courses", force: :cascade do |t|
    t.text     "detail"
    t.integer  "training_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "education_feedbacks", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "education_groups", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "education_images", force: :cascade do |t|
    t.string   "url"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["imageable_id"], name: "index_education_images_on_imageable_id", using: :btree
    t.index ["imageable_type"], name: "index_education_images_on_imageable_type", using: :btree
  end

  create_table "education_learning_programs", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "education_permissions", force: :cascade do |t|
    t.string   "entry"
    t.text     "optional"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_education_permissions_on_group_id", using: :btree
  end

  create_table "education_posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_education_posts_on_user_id", using: :btree
  end

  create_table "education_program_members", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "learning_program_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["user_id"], name: "index_education_program_members_on_user_id", using: :btree
  end

  create_table "education_project_members", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_education_project_members_on_user_id", using: :btree
  end

  create_table "education_project_techniques", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "technique_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "education_projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "core_features"
    t.string   "git_repo"
    t.text     "release_note"
    t.string   "server_info"
    t.string   "pm_url"
    t.boolean  "is_project"
    t.string   "plat_form"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "education_rates", force: :cascade do |t|
    t.integer  "rate"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_education_rates_on_user_id", using: :btree
  end

  create_table "education_socials", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_education_socials_on_user_id", using: :btree
  end

  create_table "education_techniques", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "education_training_techniques", force: :cascade do |t|
    t.integer  "training_id"
    t.integer  "technique_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "education_trainings", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "education_user_groups", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.boolean  "is_default_group"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["user_id"], name: "index_education_user_groups_on_user_id", using: :btree
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
    t.index ["company_id"], name: "index_employees_on_company_id", using: :btree
    t.index ["user_id"], name: "index_employees_on_user_id", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "company_id"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["company_id"], name: "index_groups_on_company_id", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "image_url"
    t.text     "caption"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["imageable_id"], name: "index_images_on_imageable_id", using: :btree
    t.index ["imageable_type"], name: "index_images_on_imageable_type", using: :btree
  end

  create_table "jobs", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "title"
    t.string   "describe"
    t.integer  "type_of_candidates"
    t.integer  "who_can_apply"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["company_id"], name: "index_jobs_on_company_id", using: :btree
    t.index ["title"], name: "index_jobs_on_title", using: :btree
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "entry"
    t.text     "optional"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_permissions_on_group_id", using: :btree
  end

  create_table "positions", force: :cascade do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_positions_on_company_id", using: :btree
  end

  create_table "team_introductions", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "team_target_id"
    t.string   "team_target_type"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["team_id"], name: "index_team_introductions_on_team_id", using: :btree
    t.index ["team_target_id"], name: "index_team_introductions_on_team_target_id", using: :btree
    t.index ["team_target_type"], name: "index_team_introductions_on_team_target_type", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_teams_on_company_id", using: :btree
  end

  create_table "user_groups", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "position_id"
    t.boolean  "is_default_group"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["group_id"], name: "index_user_groups_on_group_id", using: :btree
    t.index ["position_id"], name: "index_user_groups_on_position_id", using: :btree
    t.index ["user_id"], name: "index_user_groups_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "name"
    t.string   "phone"
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

  add_foreign_key "education_comments", "education_projects", column: "project_id"
  add_foreign_key "education_comments", "users"
  add_foreign_key "education_course_members", "education_courses", column: "course_id"
  add_foreign_key "education_course_members", "users"
  add_foreign_key "education_courses", "education_trainings", column: "training_id"
  add_foreign_key "education_feedbacks", "education_projects", column: "project_id"
  add_foreign_key "education_permissions", "education_groups", column: "group_id"
  add_foreign_key "education_posts", "education_categories", column: "category_id"
  add_foreign_key "education_posts", "users"
  add_foreign_key "education_program_members", "education_learning_programs", column: "learning_program_id"
  add_foreign_key "education_program_members", "users"
  add_foreign_key "education_project_members", "education_projects", column: "project_id"
  add_foreign_key "education_project_members", "users"
  add_foreign_key "education_project_techniques", "education_projects", column: "project_id"
  add_foreign_key "education_project_techniques", "education_techniques", column: "technique_id"
  add_foreign_key "education_rates", "education_projects", column: "project_id"
  add_foreign_key "education_rates", "users"
  add_foreign_key "education_socials", "users"
  add_foreign_key "education_training_techniques", "education_techniques", column: "technique_id"
  add_foreign_key "education_training_techniques", "education_trainings", column: "training_id"
  add_foreign_key "education_user_groups", "education_groups", column: "group_id"
  add_foreign_key "education_user_groups", "users"
  add_foreign_key "groups", "companies"
  add_foreign_key "permissions", "groups"
  add_foreign_key "positions", "companies"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "positions"
  add_foreign_key "user_groups", "users"
end
