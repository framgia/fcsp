class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :articles
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :education_posts, class_name: Education::Post.name
  has_many :education_socials, class_name: Education::Social.name
  has_many :education_comments, class_name: Education::Comment.name
  has_many :education_rates, class_name: Education::Rate.name
  has_many :education_project_members, class_name: Education::ProjectMember.name
  has_many :course_members, class_name: Education::CourseMember.name
  has_many :courses, through: :course_members
  has_many :education_projects, through: :education_project_members,
    source: :project
  has_many :education_user_groups, class_name: Education::UserGroup.name
  has_one :education_program_member, class_name: Education::ProgramMember.name
  has_one :education_learning_program, through: :education_program_member
  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups
  has_many :employees
  has_many :companies, through: :employees
end
