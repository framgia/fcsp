class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true,
    optional: true
  mount_uploader :picture, PictureUploader
end
