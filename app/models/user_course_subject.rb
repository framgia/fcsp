class UserCourseSubject < ApplicationRecord
  has_many :user_tasks
  has_many :comments

  belongs_to :user
  belongs_to :course_subject
end
