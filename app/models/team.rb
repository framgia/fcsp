class Team < ApplicationRecord
  belongs_to :company
  has_many :images, as: :imageable, dependent: :destroy
  has_many :team_introductions, as: :team_target
  has_many :job_teams, dependent: :destroy
  has_many :jobs, through: :job_teams

  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users

  accepts_nested_attributes_for :team_users

  validates :name, presence: true

  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :team_introductions, allow_destroy: true

  ATTRIBUTES = [:company_id, :name,
    images_attributes: [:id, :imageable_id, :imageable_type,
    :picture, :caption], user_ids: [], team_introductions_attributes:
    [:id, :team_target_id, :team_target_type, :title, :content]]

  scope :filter, ->(list_filter, sort_by, type) do
    where("#{type} IN (?)", list_filter).order "#{type} #{sort_by}"
  end
end
