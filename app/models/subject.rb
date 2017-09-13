class Subject < ApplicationRecord
  has_many :course_subjects
  has_many :tasks
end
