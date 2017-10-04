class UserCourseSubject < ApplicationRecord
  belongs_to :user
  belongs_to :subject
  belongs_to :course

  enum status: %i(init in_progress finished closed)

  delegate :name, to: :subject, prefix: true
  delegate :description, to: :subject, prefix: true
end
