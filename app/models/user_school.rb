class UserSchool < ApplicationRecord
  belongs_to :user
  belongs_to :school
  delegate :name, to: :school, prefix: true

  scope :by_schools, -> school_ids{where school_id: school_ids}
end
