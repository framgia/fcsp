class Task < ApplicationRecord
  has_many :user_tasks, dependent: :destroy

  belongs_to :subject

  enum task_type: %i(assignments test)
end
