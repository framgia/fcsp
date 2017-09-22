class UserTask < ApplicationRecord
  belongs_to :task
  belongs_to :user
  belongs_to :course
  belongs_to :subject

  enum status: %i(init in_progress finished closed)
  delegate :name, :task_type, :description, to: :task, prefix: true

  scope :check_course_subject, (lambda do |course_id, subject_id|
    where "course_id = ? AND subject_id = ?", course_id, subject_id
  end)
end
