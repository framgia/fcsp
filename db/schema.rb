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

ActiveRecord::Schema.define(version: 20170608052416) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "trackable_type"
    t.integer  "trackable_id"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "key"
    t.text     "parameters"
    t.string   "recipient_type"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  end

  create_table "addresses", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "address"
    t.float    "longitude"
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
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
    t.datetime "time_show"
    t.index ["company_id"], name: "index_articles_on_company_id", using: :btree
    t.index ["title"], name: "index_articles_on_title", using: :btree
    t.index ["user_id"], name: "index_articles_on_user_id", using: :btree
  end

  create_table "awards", force: :cascade do |t|
    t.string   "name"
    t.date     "time"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_awards_on_user_id", using: :btree
  end

  create_table "benefits", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["company_id"], name: "index_benefits_on_company_id", using: :btree
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_bookmarks_on_job_id", using: :btree
    t.index ["user_id"], name: "index_bookmarks_on_user_id", using: :btree
  end

  create_table "candidates", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "job_id"
    t.integer  "interested_in", default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "process",       default: 0
    t.index ["job_id"], name: "index_candidates_on_job_id", using: :btree
    t.index ["user_id", "job_id"], name: "index_candidates_on_user_id_and_job_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_candidates_on_user_id", using: :btree
  end

  create_table "certificates", force: :cascade do |t|
    t.string   "name"
    t.date     "qualified_time"
    t.string   "qualified_organization"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["user_id"], name: "index_certificates_on_user_id", using: :btree
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "website"
    t.text     "introduction"
    t.string   "founder"
    t.string   "country"
    t.integer  "company_size"
    t.date     "founder_on"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "avatar_id"
    t.integer  "cover_image_id"
    t.index ["avatar_id", "cover_image_id"], name: "index_companies_on_avatar_id_and_cover_image_id", unique: true, using: :btree
    t.index ["name"], name: "index_companies_on_name", using: :btree
    t.index ["website"], name: "index_companies_on_website", using: :btree
  end

  create_table "company_industries", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "industry_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["company_id"], name: "index_company_industries_on_company_id", using: :btree
    t.index ["industry_id"], name: "index_company_industries_on_industry_id", using: :btree
  end

  create_table "education_about_translations", force: :cascade do |t|
    t.integer  "education_about_id", null: false
    t.string   "locale",             null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "title"
    t.text     "content"
    t.index ["education_about_id"], name: "index_education_about_translations_on_education_about_id", using: :btree
    t.index ["locale"], name: "index_education_about_translations_on_locale", using: :btree
  end

  create_table "education_abouts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "education_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_education_categories_on_deleted_at", using: :btree
  end

  create_table "education_comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "content"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["commentable_id", "commentable_type"], name: "index_education_comments_on_commentable_id_and_commentable_type", using: :btree
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

  create_table "education_course_translations", force: :cascade do |t|
    t.integer  "education_course_id", null: false
    t.string   "locale",              null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.text     "detail"
    t.index ["education_course_id"], name: "index_education_course_translations_on_education_course_id", using: :btree
    t.index ["locale"], name: "index_education_course_translations_on_locale", using: :btree
  end

  create_table "education_courses", force: :cascade do |t|
    t.string   "name"
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
    t.string   "phone_number"
    t.string   "subject"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "education_group_translations", force: :cascade do |t|
    t.integer  "education_group_id", null: false
    t.string   "locale",             null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.text     "description"
    t.index ["education_group_id"], name: "index_education_group_translations_on_education_group_id", using: :btree
    t.index ["locale"], name: "index_education_group_translations_on_locale", using: :btree
  end

  create_table "education_groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "education_learning_program_translations", force: :cascade do |t|
    t.integer  "education_learning_program_id", null: false
    t.string   "locale",                        null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.text     "description"
    t.text     "name"
    t.index ["education_learning_program_id"], name: "index_8b0cacfb59cf9e0162ebe217e09209051f6e9f59", using: :btree
    t.index ["locale"], name: "index_education_learning_program_translations_on_locale", using: :btree
  end

  create_table "education_learning_programs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "education_permissions", force: :cascade do |t|
    t.string   "entry"
    t.text     "optional"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_education_permissions_on_group_id", using: :btree
  end

  create_table "education_post_translations", force: :cascade do |t|
    t.integer  "education_post_id", null: false
    t.string   "locale",            null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "title"
    t.index ["education_post_id"], name: "index_education_post_translations_on_education_post_id", using: :btree
    t.index ["locale"], name: "index_education_post_translations_on_locale", using: :btree
  end

  create_table "education_posts", force: :cascade do |t|
    t.text     "content"
    t.integer  "category_id"
    t.integer  "user_id"
    t.string   "cover_photo"
    t.string   "tags"
    t.integer  "comments_count", default: 0, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_education_posts_on_deleted_at", using: :btree
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
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_education_project_techniques_on_deleted_at", using: :btree
  end

  create_table "education_project_translations", force: :cascade do |t|
    t.integer  "education_project_id", null: false
    t.string   "locale",               null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.text     "description"
    t.text     "core_features"
    t.text     "release_note"
    t.index ["education_project_id"], name: "index_education_project_translations_on_education_project_id", using: :btree
    t.index ["locale"], name: "index_education_project_translations_on_locale", using: :btree
  end

  create_table "education_projects", force: :cascade do |t|
    t.string   "name"
    t.string   "git_repo"
    t.string   "server_info"
    t.string   "pm_url"
    t.boolean  "is_project"
    t.string   "plat_form"
    t.integer  "comments_count", default: 0, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_education_projects_on_deleted_at", using: :btree
  end

  create_table "education_rates", force: :cascade do |t|
    t.float    "rate",          default: 0.0
    t.integer  "user_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["rateable_id", "rateable_type"], name: "index_education_rates_on_rateable_id_and_rateable_type", using: :btree
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

  create_table "education_technique_translations", force: :cascade do |t|
    t.integer  "education_technique_id", null: false
    t.string   "locale",                 null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.text     "description"
    t.index ["education_technique_id"], name: "index_eceb63ab3bdbe51a9b3eb88ff07c8841a870b817", using: :btree
    t.index ["locale"], name: "index_education_technique_translations_on_locale", using: :btree
  end

  create_table "education_techniques", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_education_techniques_on_deleted_at", using: :btree
  end

  create_table "education_training_techniques", force: :cascade do |t|
    t.integer  "training_id"
    t.integer  "technique_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_education_training_techniques_on_deleted_at", using: :btree
  end

  create_table "education_training_translations", force: :cascade do |t|
    t.integer  "education_training_id", null: false
    t.string   "locale",                null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.text     "description"
    t.index ["education_training_id"], name: "index_education_training_translations_on_education_training_id", using: :btree
    t.index ["locale"], name: "index_education_training_translations_on_locale", using: :btree
  end

  create_table "education_trainings", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_education_trainings_on_deleted_at", using: :btree
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

  create_table "follows", force: :cascade do |t|
    t.string   "followable_type"
    t.integer  "followable_id",                   null: false
    t.string   "follower_type"
    t.integer  "follower_id",                     null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["followable_id", "followable_type"], name: "fk_followables", using: :btree
    t.index ["follower_id", "follower_type"], name: "fk_follows", using: :btree
  end

  create_table "friendships", force: :cascade do |t|
    t.string   "friendable_type"
    t.integer  "friendable_id"
    t.integer  "friend_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "blocker_id"
    t.index ["friendable_id"], name: "index_friendships_on_friendable_id", using: :btree
    t.index ["friendable_type"], name: "index_friendships_on_friendable_type", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "company_id"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["company_id"], name: "index_groups_on_company_id", using: :btree
  end

  create_table "hiring_types", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "images", force: :cascade do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "picture"
    t.text     "caption"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["imageable_id"], name: "index_images_on_imageable_id", using: :btree
    t.index ["imageable_type"], name: "index_images_on_imageable_type", using: :btree
  end

  create_table "industries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "info_users", force: :cascade do |t|
    t.integer  "relationship_status"
    t.text     "introduce"
    t.string   "quote"
    t.string   "ambition"
    t.string   "phone"
    t.string   "address"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.text     "info_statuses"
    t.index ["user_id"], name: "index_info_users_on_user_id", using: :btree
  end

  create_table "job_hiring_types", force: :cascade do |t|
    t.integer  "job_id"
    t.integer  "hiring_type_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["hiring_type_id"], name: "index_job_hiring_types_on_hiring_type_id", using: :btree
    t.index ["job_id"], name: "index_job_hiring_types_on_job_id", using: :btree
  end

  create_table "job_skills", force: :cascade do |t|
    t.integer  "job_id"
    t.integer  "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_skills_on_job_id", using: :btree
    t.index ["skill_id"], name: "index_job_skills_on_skill_id", using: :btree
  end

  create_table "job_teams", force: :cascade do |t|
    t.integer  "job_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_teams_on_job_id", using: :btree
    t.index ["team_id"], name: "index_job_teams_on_team_id", using: :btree
  end

  create_table "jobs", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "title"
    t.string   "describe"
    t.integer  "type_of_candidates", default: 0
    t.integer  "who_can_apply",      default: 0
    t.integer  "status",             default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "team_id"
    t.datetime "deleted_at"
    t.string   "profile_requests",   default: "[]", null: false
    t.integer  "candidates_count"
    t.datetime "posting_time"
    t.index ["company_id"], name: "index_jobs_on_company_id", using: :btree
    t.index ["deleted_at"], name: "index_jobs_on_deleted_at", using: :btree
    t.index ["team_id"], name: "index_jobs_on_team_id", using: :btree
    t.index ["title"], name: "index_jobs_on_title", using: :btree
  end

  create_table "languages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_likes_on_post_id", using: :btree
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "organizations", force: :cascade do |t|
    t.integer  "org_type",   default: 1
    t.string   "name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["name"], name: "index_organizations_on_name", using: :btree
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

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "author_id"
    t.integer  "likes_count",    default: 0
    t.integer  "comments_count", default: 0
    t.string   "postable_type"
    t.integer  "postable_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "image"
    t.index ["postable_type", "postable_id"], name: "index_posts_on_postable_type_and_postable_id", using: :btree
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "share_jobs", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "shareable_id"
    t.string   "shareable_type"
    t.index ["shareable_id"], name: "index_share_jobs_on_shareable_id", using: :btree
    t.index ["user_id"], name: "index_share_jobs_on_user_id", using: :btree
  end

  create_table "skill_users", force: :cascade do |t|
    t.integer  "skill_id"
    t.integer  "user_id"
    t.integer  "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_skill_users_on_skill_id", using: :btree
    t.index ["user_id"], name: "index_skill_users_on_user_id", using: :btree
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "social_networks", force: :cascade do |t|
    t.integer  "social_network_type"
    t.string   "url"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["owner_type", "owner_id"], name: "index_social_networks_on_owner_type_and_owner_id", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "team_introductions", force: :cascade do |t|
    t.integer  "team_target_id"
    t.string   "team_target_type"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
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

  create_table "user_educations", force: :cascade do |t|
    t.string   "major"
    t.date     "graduation"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "school_id"
    t.index ["school_id"], name: "index_user_educations_on_school_id", using: :btree
    t.index ["user_id"], name: "index_user_educations_on_user_id", using: :btree
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

  create_table "user_languages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "language_id"
    t.integer  "level"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["language_id"], name: "index_user_languages_on_language_id", using: :btree
    t.index ["user_id"], name: "index_user_languages_on_user_id", using: :btree
  end

  create_table "user_links", force: :cascade do |t|
    t.string   "link"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_links_on_user_id", using: :btree
  end

  create_table "user_portfolios", force: :cascade do |t|
    t.string   "url"
    t.string   "title"
    t.text     "description"
    t.date     "time"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_user_portfolios_on_user_id", using: :btree
  end

  create_table "user_projects", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_user_projects_on_user_id", using: :btree
  end

  create_table "user_works", force: :cascade do |t|
    t.string   "position"
    t.text     "description"
    t.integer  "status"
    t.date     "start_time"
    t.date     "end_time"
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["organization_id"], name: "index_user_works_on_organization_id", using: :btree
    t.index ["user_id"], name: "index_user_works_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "phone"
    t.integer  "role",                   default: 0
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
    t.string   "name"
    t.integer  "education_status",       default: 1
    t.integer  "cover_image_id"
    t.integer  "avatar_id"
    t.string   "provider"
    t.index ["avatar_id"], name: "index_users_on_avatar_id", using: :btree
    t.index ["cover_image_id"], name: "index_users_on_cover_image_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "awards", "users"
  add_foreign_key "certificates", "users"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "company_industries", "companies"
  add_foreign_key "company_industries", "industries"
  add_foreign_key "education_comments", "users"
  add_foreign_key "education_course_members", "education_courses", column: "course_id"
  add_foreign_key "education_course_members", "users"
  add_foreign_key "education_courses", "education_trainings", column: "training_id"
  add_foreign_key "education_permissions", "education_groups", column: "group_id"
  add_foreign_key "education_posts", "education_categories", column: "category_id"
  add_foreign_key "education_posts", "users"
  add_foreign_key "education_program_members", "education_learning_programs", column: "learning_program_id"
  add_foreign_key "education_program_members", "users"
  add_foreign_key "education_project_members", "education_projects", column: "project_id"
  add_foreign_key "education_project_members", "users"
  add_foreign_key "education_project_techniques", "education_projects", column: "project_id"
  add_foreign_key "education_project_techniques", "education_techniques", column: "technique_id"
  add_foreign_key "education_rates", "users"
  add_foreign_key "education_socials", "users"
  add_foreign_key "education_training_techniques", "education_techniques", column: "technique_id"
  add_foreign_key "education_training_techniques", "education_trainings", column: "training_id"
  add_foreign_key "education_user_groups", "education_groups", column: "group_id"
  add_foreign_key "education_user_groups", "users"
  add_foreign_key "groups", "companies"
  add_foreign_key "info_users", "users"
  add_foreign_key "job_hiring_types", "hiring_types"
  add_foreign_key "job_hiring_types", "jobs"
  add_foreign_key "job_teams", "jobs"
  add_foreign_key "job_teams", "teams"
  add_foreign_key "jobs", "teams"
  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "users"
  add_foreign_key "permissions", "groups"
  add_foreign_key "positions", "companies"
  add_foreign_key "share_jobs", "users"
  add_foreign_key "user_educations", "schools"
  add_foreign_key "user_educations", "users"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "positions"
  add_foreign_key "user_groups", "users"
  add_foreign_key "user_languages", "languages"
  add_foreign_key "user_languages", "users"
  add_foreign_key "user_links", "users"
  add_foreign_key "user_portfolios", "users"
  add_foreign_key "user_projects", "users"
  add_foreign_key "user_works", "organizations"
  add_foreign_key "user_works", "users"
end
