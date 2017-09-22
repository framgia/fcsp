class User < ApplicationRecord
  include ApplyJob
  include BookmarkJob

  acts_as_follower

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
  has_many :shared_jobs, through: :shares, source: :job
  has_many :user_languages, dependent: :destroy
  has_many :languages, through: :user_languages
  has_many :companies, foreign_key: :creator_id
  has_many :share_posts, class_name: ShareJob.name, dependent: :destroy
  has_many :shared_posts, through: :share_jobs, source: :post
  has_many :user_course_subjects
  has_many :user_courses
  has_many :subjects, through: :user_course_subjects
  has_many :courses, through: :user_courses
  has_many :online_contacts, dependent: :destroy
  has_many :user_tasks

  has_one :avatar, class_name: Image.name, foreign_key: :id,
    primary_key: :avatar_id
  has_one :cover_image, class_name: Image.name, foreign_key: :id,
    primary_key: :cover_image_id
  has_one :info_user, dependent: :destroy

  accepts_nested_attributes_for :info_user

  after_create :create_user_group

  delegate :introduce, :ambition, :address, :phone, :quote, :info_statuses,
    to: :info_user, prefix: true

  enum role: [:user, :admin, :employer, :employee]

  validates :name, presence: true,
    length: {maximum: Settings.user.max_length_name}
  validates :email, presence: true

  scope :newest, ->{order created_at: :desc}

  scope :not_in_object, ->object do
    where("id NOT IN (?)", object.users.pluck(:user_id)) if object.users.any?
  end

  scope :in_object, ->object do
    where("id IN (?)", object.users.pluck(:user_id))
  end

  scope :recommend, ->job_id do
    select("users.id, users.name, users.avatar_id,
      skill_users.skill_id, skill_users.level")
      .joins(:skills).where("skill_users.skill_id IN (?)",
        Skill.require_by_job(job_id).pluck(:id))
      .distinct.order("level desc").limit Settings.recommend.user_limit
  end

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
  end

  def is_user? user
    user == self
  end

  private

  def create_user_group
    self.user_groups.create
  end
end
