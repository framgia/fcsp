class Social < ApplicationRecord
  belongs_to :target, polymorphic: true

  validates :name, presence: true,
    length: {maximum: Settings.social.max_name_length}
  validates :url, presence: true,
    length: {maximum: Settings.social.max_url_length}
  validates :social_type, presence: true
end
