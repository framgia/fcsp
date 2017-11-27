class SkillUser < ApplicationRecord
  belongs_to :skill
  belongs_to :user

  validates :skill_id, uniqueness: {scope: :user_id}
  validates_numericality_of :years, greater_than: 0

  delegate :name, to: :skill, prefix: true, allow_nil: true
  delegate :description, to: :skill, prefix: true

  scope :order_by_ASC, ->{order id: :ASC}
end
