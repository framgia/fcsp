class Article < ApplicationRecord
  has_many :images, as: :imageable
  belongs_to :company
  belongs_to :user
end
