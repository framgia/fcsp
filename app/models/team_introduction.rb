class TeamIntroduction < ApplicationRecord
  belongs_to :team
  has_many :images, as: :imageable
end
