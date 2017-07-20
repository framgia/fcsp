class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true, optional: true

  mount_uploader :picture, PictureUploader

  validates :picture, presence: true, allow_blank: true
end
