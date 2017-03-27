class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  mount_uploader :url, ImageUploader
  # validates :url, presence: true
end
