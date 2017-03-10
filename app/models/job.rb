class Job < ApplicationRecord
  belongs_to :company
  has_many :images, as: :imageable
end
