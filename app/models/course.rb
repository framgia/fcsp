class Course < ApplicationRecord
  has_many :user_courses
  has_many :users, through: :user_courses
  has_many :user_course_subjects
  has_many :subjects, through: :course_subjects
  has_many :user_tasks

  belongs_to :programming_language

  enum status:  %i(init in_progress finished closed)
end
