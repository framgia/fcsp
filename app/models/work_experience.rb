class WorkExperience < ApplicationRecord
  belongs_to :user

  validates :organization, presence: true
  validates :date_from, presence: true
  validates :date_to, presence: true
  validates :position, presence: true
  validates :job_requirement, presence: true

  scope :order_by_created_at, -> {order(created_at: :asc)}
end
