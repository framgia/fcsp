class GroupSkill < ApplicationRecord
  has_many :skills, dependent: :destroy
end
