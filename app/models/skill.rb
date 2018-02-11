class Skill < ApplicationRecord
  enum skill_type: %i(hard_skill soft_skill)

  has_many :skill_users, dependent: :destroy
  has_many :users, through: :skill_users

  belongs_to :group_skill

  validates :name, presence: true, length: {maximum: Settings.max_length_title}

  accepts_nested_attributes_for :skill_users
end
