class User < ApplicationRecord
  include PublicActivity::Model

  acts_as_follower
  acts_as_followable

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :images, as: :imageable, dependent: :destroy
  has_many :skill_users, dependent: :destroy
  has_many :skills, through: :skill_users
  has_many :user_schools, dependent: :destroy
  has_many :schools, through: :user_schools
  has_many :user_languages, dependent: :destroy
  has_many :languages, through: :user_languages
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
  has_many :work_experiences

  has_one :avatar, class_name: Image.name, foreign_key: :id,
    primary_key: :avatar_id
  has_one :cover_image, class_name: Image.name, foreign_key: :id,
    primary_key: :cover_image_id
  has_one :info_user, dependent: :destroy

  accepts_nested_attributes_for :info_user, update_only: true

  delegate :address, :phone, :quote, :info_statuses,
    :birthday, :relationship_status, :occupation, :introduction, :gender,
    :id, to: :info_user, prefix: true

  enum role: %i(employer trainee admin)

  validates :name, presence: true, length: {maximum: Settings.user.max_length_name}
  validates :email, presence: true

  scope :recommend, (lambda do
    select("users.id, users.name, users.avatar_id, users.email")
      .limit Settings.recommend.user_limit
  end)

  scope :other_user, (lambda do |id|
    select("id, name, email").where("id != ?", id)
  end)

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
