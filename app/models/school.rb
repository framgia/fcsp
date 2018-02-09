class School < ApplicationRecord
  has_many :user_schools
  has_many :users, through: :user_schools, source: :user

  validates :name, presence: true, length: {
    maximum: Settings.user_educations.school_max
  }

  accepts_nested_attributes_for :user_schools
end
