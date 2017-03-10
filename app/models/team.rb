class Team < ApplicationRecord
  has_many :team_introductions, as: :team_target_type
  belongs_to :company
end
