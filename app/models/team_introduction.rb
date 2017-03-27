class TeamIntroduction < ApplicationRecord
  has_many :images, as: :imageable
  belongs_to :team_target, polymorphic: true
  accepts_nested_attributes_for :images, allow_destroy: true
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true, uniqueness: true

  ATTRIBUTES = [:team_target_id, :team_target_type, :title, :content,
    images_attributes: [:id, :imageable_id, :imageable_type, :image_url, :caption]]
end
