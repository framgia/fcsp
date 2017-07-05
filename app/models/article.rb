class Article < ApplicationRecord
  include Concerns::CheckPostTime

  has_many :images, as: :imageable, dependent: :destroy
  belongs_to :company
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true
  validates :description, presence: true
  validates :time_show, presence: true
  validate :check_time_show

  delegate :name, to: :company, prefix: true

  accepts_nested_attributes_for :images
  ATTRIBUTES = [:title, :content, :description, :time_show,
    images_attributes: [:id, :imageable_id, :imageable_type, :picture,
    :caption]].freeze

  scope :search_form, ->(search, type, sort_by) do
    where("LOWER(title) LIKE ? OR LOWER(description) LIKE ?",
      "%#{search}%", "%#{search}%").order "#{type} #{sort_by}"
  end

  scope :time_filter, lambda{
    where("time_show <= ?", Time.zone.now).order time_show: :DESC
  }

  def background_image
    images.first.picture
  end

  private

  def check_time_show
    check_time time_show if time_show_was > Time.zone.now
  end
end
