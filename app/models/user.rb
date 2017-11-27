class User < ApplicationRecord
  include ApplyJob
  include BookmarkJob
  include PublicActivity::Model

  acts_as_follower
  acts_as_followable

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :user_groups, dependent: :destroy
  has_many :employer_groups, class_name: Group.name, through: :user_groups,
    source: :group
  has_many :images, as: :imageable, dependent: :destroy
  has_many :candidates, dependent: :destroy
  has_many :jobs, through: :candidates
  has_many :created_jobs, class_name: Job.name, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_jobs, class_name: Job.name, through: :bookmarks,
    source: :job
  has_many :skill_users, dependent: :destroy
  has_many :skills, through: :skill_users
  has_many :user_schools, dependent: :destroy
  has_many :schools, through: :user_schools
  has_many :shares, class_name: ShareJob.name, dependent: :destroy
  has_many :share_jobs, source: :job
  has_many :user_languages, dependent: :destroy
  has_many :languages, through: :user_languages
  has_one :company, foreign_key: :creator_id
  has_many :share_posts, class_name: ShareJob.name, dependent: :destroy
  has_many :user_course_subjects
  has_many :user_courses
  has_many :subjects, through: :user_course_subjects
  has_many :courses, through: :user_courses
  has_many :online_contacts, dependent: :destroy
  has_many :user_tasks
  has_many :active_shares, class_name: ShareProfile.name,
    foreign_key: :user_shared_id, dependent: :destroy
  has_many :passive_shares, class_name: ShareProfile.name,
    foreign_key: :user_share_id, dependent: :destroy
  has_many :user_shares, through: :active_shares, source: :user_share
  has_many :shared, through: :passive_shares, source: :user_shared

  has_one :avatar, class_name: Image.name, foreign_key: :id,
    primary_key: :avatar_id
  has_one :cover_image, class_name: Image.name, foreign_key: :id,
    primary_key: :cover_image_id
  has_one :info_user, dependent: :destroy

  accepts_nested_attributes_for :info_user, update_only: true

  delegate :ambition, :address, :phone, :quote, :info_statuses,
    :birthday, :relationship_status, :occupation, :country, :introduction, :gender,
    :id, to: :info_user, prefix: true

  enum role: %i(employer trainee admin)

  validates :name, presence: true, length: {maximum: Settings.user.max_length_name}
  validates :email, presence: true
  validates :auto_synchronize, inclusion: {in: [true, false]}

  scope :newest, ->{order created_at: :desc}

  scope :not_in_object, ->object do
    where("id NOT IN (?)", object.users.pluck(:user_id)) if object.users.any?
  end

  scope :in_object, ->object do
    where("id IN (?)", object.users.pluck(:user_id))
  end

  scope :recommend, (lambda do
    select("users.id, users.name, users.avatar_id, users.email").includes(:avatar)
      .limit Settings.recommend.user_limit
  end)

  scope :user_all, (lambda do |id|
    select("id, name, email").where("id != ?", id)
  end)

  scope :filter_trainee, (lambda do |list_filter, sort_by, user_type, data_table|
    list_filter.map!{|element| element == "" ? nil : element}
    date_filter = ["birthday"]

    if date_filter.include? user_type
      list_filter = InfoUser.all.pluck(user_type).uniq.reject{
        |element| list_filter.exclude? (element.to_date.to_s if element)}
    end

    where("#{data_table}.#{user_type}": list_filter).
      order "#{data_table}.#{user_type} #{sort_by}"
  end)

  scope :filter_trainee_course, (lambda do |course|
    where "courses.id": course
  end)

  scope :filter_trainee_programming_language, (lambda do |language|
    where "programming_languages.id": language
  end)

  scope :want_auto_sync, ->{where auto_synchronize: true}

  scope :search_user, (lambda do |name|
    where "name LIKE ? ", "%#{name}%"
  end)

  class << self
    def import file
      (2..spreadsheet(file).last_row).each do |row|
        value = Hash[[header_of_file(file),
          spreadsheet(file).row(row)].transpose]
        user = find_by(id: value["id"]) || new
        user.attributes = value.to_hash.slice *value.to_hash.keys
        unless user.save
          raise "#{I18n.t('education.import_user.row_error')} #{row}: \
            #{user.errors.full_messages}"
        end
      end
    end

    def open_spreadsheet file
      case File.extname file.original_filename
      when ".csv" then Roo::CSV.new file.path
      when ".xls" then Roo::Excel.new file.path
      when ".xlsx" then Roo::Excelx.new file.path
      else raise "#{I18n.t('education.import_user.unknow_format')}: \
        #{file.original_filename}"
      end
    end

    def spreadsheet file
      open_spreadsheet file
    end

    def header_of_file file
      spreadsheet(file).row 1
    end

    def from_omniauth auth
      User.find_or_initialize_by(email: auth.info.email).tap do |user|
        user.name = auth.info.name
        user.provider = auth.provider
        user.password = User.generate_unique_secure_token if user.new_record?
        user.save
      end
    end

    def pluck_params_type id, type
      where(id: id).pluck(type).first
    end
  end

  def is_user? user
    user == self
  end

  def add_share user
    user_shares << user
  end

  def delete_share user
    user_shares.delete user
  end

  def share? user
    user_shares.include? user
  end
end
