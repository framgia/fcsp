class Skill < ApplicationRecord
  has_many :job_skills, dependent: :destroy
  has_many :jobs, through: :job_skills
  has_many :skill_users, dependent: :destroy
  has_many :users, through: :skill_users

  belongs_to :group_skill

  validates :name, presence: true, uniqueness: true,
    length: {maximum: Settings.max_length_title}
  validates :description, length: {maximum: Settings.max_length_description}

  scope :require_by_job, ->job_id do
    joins(:jobs).where("job_skills.job_id = ?", job_id)
  end
end
