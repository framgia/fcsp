class Comment < ApplicationRecord
  belongs_to :user_course
  belongs_to :user_course_subject
  belongs_to :user_task
end
