class Task < ApplicationRecord
  has_many :user_tasks

  belongs_to :subject
end
