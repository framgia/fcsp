class Article < ApplicationRecord
  has_many :images, as: :imageable, dependent: :destroy
  belongs_to :company
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true
  validates :description, presence: true
  validates :images, presence: true
  validates :time_show, presence: true

  accepts_nested_attributes_for :images
  ATTRIBUTES = [:title, :content, :description, :time_show,
    images_attributes: [:id, :imageable_id, :imageable_type, :picture,
    :caption]].freeze

  scope :search_form, ->(search) do
    where "LOWER(title) LIKE ? OR LOWER(description)
      LIKE ?", "%#{search}%", "%#{search}%"
  end
  # only use with user's view
  scope :show, ->(time_show) do
    where "time_show <= ?", Time.now
  end
end
