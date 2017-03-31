class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :articles
  has_many :education_posts, class_name: Education::Post.name
  has_many :education_socials, class_name: Education::Social.name
  has_many :education_comments, class_name: Education::Comment.name
  has_many :education_rates, class_name: Education::Rate.name
  has_many :education_project_members, class_name: Education::ProjectMember.name
  has_many :course_members, class_name: Education::CourseMember.name
  has_many :education_courses, through: :course_members, source: :course
  has_many :education_projects, through: :education_project_members,
    source: :project
  has_many :education_user_groups, class_name: Education::UserGroup.name
  has_many :education_groups, class_name: Education::Group.name,
    through: :education_user_groups, source: :group
  has_one :education_program_member, class_name: Education::ProgramMember.name
  has_one :education_learning_program, through: :education_program_member
  has_many :user_groups, dependent: :destroy
  has_many :employer_groups, class_name: Group.name, through: :user_groups,
    source: :group
  has_many :images, as: :imageable, dependent: :destroy
  has_many :education_images, class_name: Education::Image.name,
    as: :imageable, dependent: :destroy
  has_many :candidates, dependent: :destroy
  has_many :jobs, through: :candidates
  has_many :bookmarks, dependent: :destroy
  has_one :info_user
  has_many :employees
  has_many :companies, through: :employees

  delegate :introduce, :ambition, :quote, to: :info_user, prefix: true

  mount_uploader :avatar, AvatarUploader
  enum role: [:user, :admin]

  after_create :create_user_group

  validates :name, presence: true,
    length: {maximum: Settings.user.max_length_name}
  validates :email, presence: true

  scope :not_in_object, ->object do
    where("id NOT IN (?)", object.users.pluck(:user_id)) if object.users.any?
  end

  def bookmark job
    bookmarks.create job_id: job.id
  end

  def unbookmark job
    bookmarks.find_by(job_id: job.id).destroy
  end

  def apply_job job
    candidates.create job_id: job.id
  end

  def unapply_job job
    candidates.find_by(job_id: job.id).destroy if job.present?
  end

  private

  def create_user_group
    self.user_groups.create
  end
end
