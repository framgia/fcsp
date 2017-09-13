class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :comments
end
