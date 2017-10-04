class SkillUser < ApplicationRecord
  belongs_to :skill
  belongs_to :user

  validates :user, presence: true
  validates :skill, presence: true

  delegate :name, to: :skill, prefix: true, allow_nil: true
  delegate :description, to: :skill, prefix: true
end
