class CourseSubject < ApplicationRecord
  has_many :user_course_subjects

  belongs_to :course
  belongs_to :subject

  enum status: %i(init in_progress finished closed)
  delegate :name, to: :subject
end
