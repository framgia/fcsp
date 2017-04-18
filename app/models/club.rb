class Club < ApplicationRecord
  belongs_to :user

  validates :name, presence: true,
    length: {maximum: Settings.club.max_name_length}
  validates :description, presence: true,
    length: {maximum: Settings.club.max_description_length}
  validates :image, presence: true
end
