class Course < ApplicationRecord
  has_many :user_courses
  has_many :user_subjects

  belongs_to :programming_language
end
